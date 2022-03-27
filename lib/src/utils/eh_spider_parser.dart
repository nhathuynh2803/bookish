import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:jhentai/src/consts/color_consts.dart';
import 'package:jhentai/src/model/base_gallery.dart';
import 'package:jhentai/src/model/gallery_comment.dart';
import 'package:jhentai/src/model/gallery_detail.dart';
import 'package:jhentai/src/model/gallery_image.dart';
import 'package:jhentai/src/model/gallery_thumbnail.dart';
import 'package:jhentai/src/model/gallery_torrent.dart';
import 'package:jhentai/src/setting/site_setting.dart';

import '../database/database.dart';
import '../model/gallery.dart';
import '../pages/home/tab_view/ranklist/ranklist_view_state.dart';

class EHSpiderParser {
  static String? parseUserInfo(String html) {
    Document document = parse(html);

    /// cookie is wrong, not logged in
    if (document.querySelector('.pcen') != null) {
      return null;
    }

    return document.querySelector('.home > b > a')!.text;
  }

  static List<dynamic> parseGalleryList(Response response) {
    String html = response.data!;
    Document document = parse(html);
    List<Element> galleryListElements = document.querySelectorAll('.itg.gltc > tbody > tr');

    /// no data
    if (galleryListElements.isEmpty) {
      return [<Gallery>[], 0];
    }

    /// remove table header
    galleryListElements.removeAt(0);

    /// remove ad or [no result row]
    galleryListElements.removeWhere((element) => element.children.length == 1);
    List<Gallery> gallerys = galleryListElements.map((e) => _parseGallery(e)).toList();

    int pageCount = gallerys.isEmpty ? 0 : _parseHomeGalleryTotalPageCount(document);
    return [gallerys, pageCount];
  }

  static Gallery parseGalleryByUrl(Response<String> response) {
    String html = response.data!;
    Document document = parse(html);

    String galleryUrl = document.querySelector('#gd5 > p > a')!.attributes['href']!.split('?')[0];
    List<String>? parts = galleryUrl.split('/');
    String coverStyle = document.querySelector('#gd1 > div')?.attributes['style'] ?? '';
    RegExpMatch coverMatch = RegExp(r'width:(\d+)px.*height:(\d+)px.*url\((.*)\)').firstMatch(coverStyle)!;
    LinkedHashMap<String, List<TagData>> tags = _parseGalleryTagsByUrl(document);

    Gallery gallery = Gallery(
      gid: int.parse(parts[4]),
      token: parts[5],
      title: document.querySelector('#gn')?.text ?? '',
      japaneseTitle: document.querySelector('#gj')?.text,
      category: document.querySelector('#gdc > .cs')?.text ?? '',
      cover: GalleryImage(
        url: coverMatch.group(3)!,
        height: double.parse(coverMatch.group(2)!),
        width: double.parse(coverMatch.group(1)!),
      ),
      pageCount: int.parse(
          (document.querySelector('#gdd > table > tbody > tr:nth-child(5) > .gdt2')?.text ?? '').split(' ')[0]),
      rating: _parseGalleryRating(document.querySelector('#grt2')!),
      hasRated: document.querySelector('#grt2 > #rating_image .ir.irg') != null ? true : false,
      isFavorite: document.querySelector('#fav > .i') != null ? true : false,
      favoriteTagIndex: _parseFavoriteTagIndexByOffset(document),
      favoriteTagName: document.querySelector('#favoritelink')!.hasChildNodes()
          ? null
          : document.querySelector('#favoritelink')?.text,
      galleryUrl: galleryUrl,
      tags: tags,
      language: tags['language']?[0].key,
      uploader: document.querySelector('#gdn > a')?.text ?? '',
      publishTime: document.querySelector('#gdd > table > tbody > tr > .gdt2')?.text ?? '',
    );

    return gallery;
  }

  static Map<RanklistType, List<BaseGallery>> parse4Ranklists(Response response) {
    String html = response.data!;
    Document document = parse(html);

    List<Element> rankLists = document.querySelectorAll('.dc > .tdo');

    return {
      RanklistType.allTime: _parseRanklist(rankLists[0]),
      RanklistType.year: _parseRanklist(rankLists[1]),
      RanklistType.month: _parseRanklist(rankLists[2]),
      RanklistType.day: _parseRanklist(rankLists[3]),
    };
  }

  static Map<String, dynamic> galleryDetail2DetailAndApikey(Response<String> response) {
    String html = response.data!;
    Document document = parse(html);

    GalleryDetail galleryDetail = GalleryDetail(
      ratingCount: int.parse(document.querySelector('#rating_count')?.text ?? '0'),
      realRating: _parseGalleryDetailsRealRating(document),
      size: document.querySelector('#gdd > table > tbody')?.children[4].children[1].text ?? '',
      favoriteCount: _parseGalleryDetailsFavoriteCount(document),
      torrentCount: RegExp(r'\d+')
              .firstMatch(document.querySelector('#gd5')?.children[2].querySelector('a')?.text ?? '')
              ?.group(0) ??
          '0',
      torrentPageUrl:
          document.querySelector('#gd5')?.children[2].querySelector('a')?.attributes['onclick']?.split('\'')[1] ?? '',
      archivePageUrl:
          document.querySelector('#gd5')?.children[1].querySelector('a')?.attributes['onclick']?.split('\'')[1] ?? '',
      fullTags: _parseGalleryTagsByUrl(document),
      comments: _parseGalleryDetailsComments(document.querySelectorAll('#cdiv > .c1')),
      thumbnails: parseGalleryDetailsThumbnails(html),
    );

    return {'galleryDetails': galleryDetail, 'apikey': _galleryDetailDocument2Apikey(document)};
  }

  static Map<String, dynamic> galleryDetail2GalleryAndDetailAndApikey(Response<String> response) {
    Map<String, dynamic> map = galleryDetail2DetailAndApikey(response);
    map['gallery'] = parseGalleryByUrl(response);
    return map;
  }

  static List<GalleryThumbnail> parseGalleryDetailsThumbnails(String html) {
    Document document = parse(html);

    List<Element> thumbNailElements = document.querySelectorAll('#gdt > .gdtm');
    if (thumbNailElements.isNotEmpty) {
      return _parseGalleryDetailsSmallThumbnails(thumbNailElements);
    }
    thumbNailElements = document.querySelectorAll('#gdt > .gdtl');
    return _parseGalleryDetailsLargeThumbnails(thumbNailElements);
  }

  static List<GalleryComment> parseGalleryDetailsComments(String html) {
    Document document = parse(html);
    List<Element> commentElements = document.querySelectorAll('#cdiv > .c1');
    return _parseGalleryDetailsComments(commentElements);
  }

  static List<String> parseFavoritePopup(String html) {
    Document document = parse(html);
    List<Element> divs = document.querySelectorAll('.nosel > div');
    return divs.map((div) => div.querySelector('div:nth-child(5)')?.text ?? '').toList();
  }

  static LinkedHashMap<String, int> parseFavoriteTags(String html) {
    Document document = parse(html);
    List<Element> divs = document.querySelectorAll('.nosel > .fp');

    /// not favorite tag
    divs.removeLast();
    LinkedHashMap<String, int> tagNames2Count = LinkedHashMap();

    for (Element div in divs) {
      String tagName = div.querySelector('div:last-child')?.text ?? '';
      int favoriteCount = int.parse(div.querySelector('div:first-child')?.text ?? '0');
      tagNames2Count.putIfAbsent(tagName, () => favoriteCount);
    }

    return tagNames2Count;
  }

  static GalleryImage parseGalleryImage(String html) {
    Document document = parse(html);
    Element img = document.querySelector('#img')!;

    /// height: 1600px; width: 1124px;
    String style = img.attributes['style']!;

    return GalleryImage(
      url: img.attributes['src']!,
      height: double.parse(RegExp(r'height:(\d+)px').firstMatch(style)!.group(1)!),
      width: double.parse(RegExp(r'width:(\d+)px').firstMatch(style)!.group(1)!),
    );
  }

  static String? parseSendCommentErrorMsg(Response<String> response) {
    String? html = response.data;
    if (html?.isEmpty ?? true) {
      return null;
    }
    Document document = parse(html);
    return document.querySelector('p.br')?.text;
  }

  static List<GalleryTorrent> parseTorrent(Response<String> response) {
    String html = response.data!;
    Document document = parse(html);

    List<Element> torrentForms = document.querySelectorAll('#torrentinfo > div > form');
    torrentForms.removeWhere((form) => form.querySelector('div > table > tbody > tr:nth-child(4) > td > a') == null);

    return torrentForms.map(
      (form) {
        List<Element> trs = form.querySelectorAll('div > table > tbody > tr');
        return GalleryTorrent(
          title: trs[2].querySelector('td > a')!.text,
          postTime: trs[0].querySelector('td:nth-child(1)')!.text.substring(8),
          size: trs[0].querySelector('td:nth-child(3)')!.text.substring(6),
          seeds: int.parse(trs[0].querySelector('td:nth-child(7)')!.text.substring(7)),
          peers: int.parse(trs[0].querySelector('td:nth-child(9)')!.text.substring(7)),
          downloads: int.parse(trs[0].querySelector('td:nth-child(11)')!.text.substring(11)),
          uploader: trs[1].querySelector('td:nth-child(1)')!.text.substring(10),
          torrentUrl: trs[2].querySelector('td > a')!.attributes['href']!,
          magnetUrl:
              'magnet:?xt=urn:btih:${trs[2].querySelector('td > a')!.attributes['href']!.split('.')[1].split('/').last}',
        );
      },
    ).toList();
  }

  static Map<String, dynamic> setting2SiteSetting(Response<String> response) {
    String html = response.data!;
    Document document = parse(html);
    List<Element> items = document.querySelectorAll('.optouter');
    Map<String, dynamic> map = {};

    Element frontPageSetting = items[6];
    String type = frontPageSetting.querySelector('div > p > label > input[checked=checked]')!.parent!.text;

    switch (type) {
      case ' Minimal':
        map['frontPageDisplayType'] = FrontPageDisplayType.minimal;
        break;
      case ' Minimal+':
        map['frontPageDisplayType'] = FrontPageDisplayType.minimalPlus;
        break;
      case ' Compact':
        map['frontPageDisplayType'] = FrontPageDisplayType.compact;
        break;
      case ' Extended':
        map['frontPageDisplayType'] = FrontPageDisplayType.extended;
        break;
      case ' Thumbnail':
        map['frontPageDisplayType'] = FrontPageDisplayType.thumbnail;
        break;
    }

    Element thumbnailSetting = items[18];
    map['isLargeThumbnail'] =
        thumbnailSetting.querySelector('#tssel > div > label > input[checked=checked]')!.parent!.text == ' Large'
            ? true
            : false;
    map['thumbnailRows'] =
        int.parse(thumbnailSetting.querySelector('#trsel > div > label > input[checked=checked]')!.parent!.text);
    return map;
  }

  static int _parseHomeGalleryTotalPageCount(Document document) {
    Element? tr = document.querySelector('.ptt > tbody > tr');
    Element? td = tr?.children[tr.children.length - 2];
    return int.parse(td?.querySelector('a')?.text ?? '1');
  }

  static Gallery _parseGallery(Element tr) {
    LinkedHashMap<String, List<TagData>> tags = _parseGalleryTags(tr);
    GalleryImage? cover = _parseGalleryCover(tr);
    String galleryUrl = tr.querySelector('.gl3c.glname > a')?.attributes['href'] ?? '';
    List<String> parts = galleryUrl.split('/');

    Gallery gallery = Gallery(
      gid: int.parse(parts[4]),
      token: parts[5],
      title: tr.querySelector('.glink')?.text ?? '',
      category: tr.querySelector('.cn')?.text ?? '',
      cover: cover!,
      pageCount: _parseGalleryListPageCount(tr),
      rating: _parseGalleryRating(tr),
      hasRated: tr.querySelector('.gl2c > div:nth-child(2) > .ir.irb') != null ? true : false,
      isFavorite: tr.querySelector('.gl2c > div:nth-child(2) > [id][style]') != null ? true : false,
      favoriteTagIndex: _parseFavoriteTagIndex(tr),
      favoriteTagName: tr.querySelector('.gl2c > div:nth-child(2) > [id][style]')?.attributes['title'],
      galleryUrl: galleryUrl,
      tags: tags,
      language: tags['language']?[0].key,
      uploader: tr.querySelector('.gl4c.glhide > div > a')?.text ?? '',
      publishTime: tr.querySelector('.gl2c > div:nth-child(2) > [id]')?.text ?? '',
    );

    return gallery;
  }

  static LinkedHashMap<String, List<TagData>> _parseGalleryTags(Element tr) {
    LinkedHashMap<String, List<TagData>> tags = LinkedHashMap();

    List<Element> tagDivs = tr.querySelectorAll('.gt').toList();
    for (Element tagDiv in tagDivs) {
      /// eg: language:english
      String pair = tagDiv.attributes['title'] ?? '';
      if (pair.isEmpty) {
        continue;
      }

      /// some tag doesn't has a type
      List<String> list = pair.split(':').toList();
      String namespace = list[0].isNotEmpty ? list[0] : 'temp';
      String key = list[1];

      tags.putIfAbsent(namespace, () => []).add(TagData(namespace: namespace, key: key));
    }
    return tags;
  }

  static LinkedHashMap<String, List<TagData>> _parseGalleryTagsByUrl(Document document) {
    LinkedHashMap<String, List<TagData>> tags = LinkedHashMap();

    List<Element> trs = document.querySelectorAll('#taglist > table > tbody > tr').toList();
    for (Element tr in trs) {
      List<Element> tagDivs = tr.querySelectorAll('td:nth-child(1) > div').toList();
      for (Element tagDiv in tagDivs) {
        /// eg: language:english
        String pair = tagDiv.attributes['id'] ?? '';
        if (pair.isEmpty) {
          continue;
        }

        /// some tag doesn't has a type
        List<String> list = pair.split(':').toList();
        String namespace = list.length == 2 && list[0].isNotEmpty ? list[0].split('_')[1] : 'temp';
        String key = list.length == 1 ? list[0].substring(3).replaceAll('\_', ' ') : list[1].replaceAll('\_', ' ');

        tags.putIfAbsent(namespace, () => []).add(TagData(namespace: namespace, key: key));
      }
    }
    return tags;
  }

  static GalleryImage? _parseGalleryCover(Element tr) {
    Element? img = tr.querySelector('.gl2c > .glthumb > div > img');
    if (img == null) {
      return null;
    }
    String coverUrl = img.attributes['data-src'] ?? img.attributes['src'] ?? '';

    /// eg: height:296px;width:250px
    String? style = img.attributes['style'];
    if (style == null) {
      return null;
    }
    RegExp sizeReg = RegExp(r'(\d+)');
    List<RegExpMatch> sizes = sizeReg.allMatches(style).toList();

    String? height = sizes[0].group(0);
    String? width = sizes[1].group(0);
    if (height == null || width == null) {
      return null;
    }
    return GalleryImage(
      url: coverUrl,
      height: double.parse(height),
      width: double.parse(width),
    );
  }

  static int _parseGalleryListPageCount(Element tr) {
    List<Element> divs = tr.querySelectorAll('.gl4c.glhide > div');

    /// favorite page
    if (divs.isEmpty) {
      return 0;
    }

    /// eg: '66 pages'
    String pageCountDesc = divs[1].text;
    return int.parse(pageCountDesc.split(' ')[0]);
  }

  static List<BaseGallery> _parseRanklist(Element ranklistDiv) {
    List<Element> trs = ranklistDiv.querySelectorAll('table > tbody > tr');
    return trs
        .map(
          (tr) => BaseGallery(
            galleryUrl: tr.querySelector('.tun > a')!.attributes['href']!,
            title: tr.querySelector('.tun > a')!.text,
          ),
        )
        .toList();
  }

  static double _parseGalleryRating(Element tr) {
    /// eg: style="background-position:-16px -1px;opacity:1"
    String style = tr.querySelector('.ir')?.attributes['style'] ?? '';
    if (style.isEmpty) {
      return 0;
    }

    RegExp offsetsReg = RegExp(r'-*(\d+)+px');
    List<RegExpMatch> offsets = offsetsReg.allMatches(style).toList();

    /// eg: '0px'  '-16px'  '-32px'
    String? xOffset = offsets[0].group(0);

    /// eg: '-1px'  '-21px'
    String? yOffset = offsets[1].group(0);

    if (xOffset == null || yOffset == null) {
      return 0;
    }

    int xOffsetInt = int.parse(xOffset.replaceAll('px', ''));
    int yOffsetInt = int.parse(yOffset.replaceAll('px', ''));

    double initValue = 5;
    initValue -= -xOffsetInt / 16;
    initValue -= yOffsetInt == -21 ? 0.5 : 0;

    return initValue;
  }

  static int? _parseFavoriteTagIndex(Element tr) {
    String? style = tr.querySelector('.gl2c > div:nth-child(2) > [id][style]')?.attributes['style'];
    if (style == null) {
      return null;
    }
    final String color = RegExp(r'border-color:#(\w{3});').firstMatch(style)?.group(1) ?? '';
    return ColorConsts.favoriteTagIndex[color]!;
  }

  static int? _parseFavoriteTagIndexByOffset(Document document) {
    String? style = document.querySelector('#fav > .i')?.attributes['style'];
    if (style == null) {
      return null;
    }
    int offset = int.parse(RegExp(r'background-position:0px -(\d+)px').firstMatch(style)!.group(1)!);
    return (offset - 2) ~/ 19;
  }

  static double _parseGalleryDetailsRealRating(Document document) {
    /// eg: 'Average: 4.76' 'Not Yet Rated'
    String raw = document.querySelector('#rating_label')?.text ?? '';
    return double.parse(RegExp(r'Average: (\d+.\d+\d+)').firstMatch(raw)?.group(1) ?? '0');
  }

  static int _parseGalleryDetailsFavoriteCount(Document document) {
    String? count = document.querySelector('#favcount')?.text;
    if (count == null || count == 'Never') {
      return 0;
    } else if (count == 'Once') {
      return 1;
    } else {
      return int.parse(count.split(' ')[0]);
    }
  }

  static List<GalleryComment> _parseGalleryDetailsComments(List<Element> commentElements) {
    return commentElements.map((element) {
      /// eg: 'Posted on 10 March 2022, 03:49 by: hibiki'
      String timeDesc = element.querySelector('.c2 > .c3')?.text ?? '';

      /// eg: '10 March 2022, 03:49'
      String timeString = RegExp(r'Posted on (.+, .+) by:').firstMatch(timeDesc)?.group(1) ?? '';
      final DateTime utcTime = DateFormat('dd MMMM yyyy, HH:mm', 'en_US').parseUtc(timeString).toLocal();
      final String localTime = DateFormat('yyyy-MM-dd HH:mm').format(utcTime);

      return GalleryComment(
        id: int.parse(element.querySelector('.c6')?.attributes['id']?.split('_')[1] ?? ''),
        userName: element.querySelector('.c2 > .c3')?.children[0].text ?? '',
        score: element.querySelector('.c2 > .c5.nosel > span')?.text ?? '',
        content: element.querySelector('.c6')?.outerHtml ?? '',
        time: localTime,
      );
    }).toList();
  }

  static List<GalleryThumbnail> _parseGalleryDetailsSmallThumbnails(List<Element> thumbNailElements) {
    return thumbNailElements.map((element) {
      String href = element.querySelector('div > a')?.attributes['href'] ?? '';
      String style = element.querySelector('div')?.attributes['style'] ?? '';

      return GalleryThumbnail(
        href: href,
        thumbUrl: RegExp(r'url\((.+)\)').firstMatch(style)?.group(1) ?? '',
        isLarge: false,
        thumbWidth: double.parse(RegExp(r'width:(\d+)?px').firstMatch(style)?.group(1) ?? '0'),
        thumbHeight: double.parse(RegExp(r'height:(\d+)?px').firstMatch(style)?.group(1) ?? '0') - 1,
        offSet: double.parse(RegExp(r'\) -(\d+)?px ').firstMatch(style)?.group(1) ?? '0'),
      );
    }).toList();
  }

  static List<GalleryThumbnail> _parseGalleryDetailsLargeThumbnails(List<Element> thumbNailElements) {
    return thumbNailElements.map((element) {
      String thumbUrl = element.querySelector('a > img')?.attributes['src'] ?? '';
      List<String> parts = thumbUrl.split('-');
      return GalleryThumbnail(
        href: element.querySelector('a')?.attributes['href'] ?? '',
        thumbUrl: thumbUrl,
        isLarge: true,
        thumbWidth: double.parse(parts[2]),
        thumbHeight: double.parse(parts[3]),
      );
    }).toList();
  }

  static String _galleryDetailDocument2Apikey(Document document) {
    String script = document.querySelector('.gm')?.previousElementSibling?.text ?? '';
    return RegExp(r'var apikey = "(\w+)"').firstMatch(script)?.group(1) ?? '';
  }
}