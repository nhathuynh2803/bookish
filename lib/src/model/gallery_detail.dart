import 'dart:collection';

import 'package:jhentai/src/model/child_gallery.dart';
import 'package:jhentai/src/model/gallery.dart';
import 'package:jhentai/src/model/gallery_url.dart';

import 'base_model.dart';
import 'gallery_comment.dart';
import 'gallery_image.dart';
import 'gallery_tag.dart';
import 'gallery_thumbnail.dart';

class GalleryDetail extends Model<GalleryDetail> {
  GalleryUrl galleryUrl;
  String rawTitle;
  String? japaneseTitle;
  String category;
  GalleryImage cover;
  int pageCount;
  double rating;

  /// real rating, not the one we rated
  double realRating;
  bool hasRated;
  int ratingCount;
  int? favoriteTagIndex;
  String? favoriteTagName;

  int favoriteCount;
  String language;

  /// null for disowned gallery
  String? uploader;
  String publishTime;
  bool isExpunged;

  /// full tags: tags in Gallery may be incomplete
  LinkedHashMap<String, List<GalleryTag>> tags;

  String size;
  String torrentCount;
  String torrentPageUrl;
  String archivePageUrl;
  GalleryUrl? parentGalleryUrl;
  List<ChildGallery>? childrenGallerys;
  List<GalleryComment> comments;
  List<GalleryThumbnail> thumbnails;
  int thumbnailsPageCount;

  bool get isFavorite => favoriteTagIndex != null || favoriteTagName != null;

  GalleryUrl? get newVersionGalleryUrl => childrenGallerys?.lastOrNull?.galleryUrl;

  GalleryDetail({
    required this.galleryUrl,
    required this.rawTitle,
    this.japaneseTitle,
    required this.category,
    required this.cover,
    required this.pageCount,
    required this.rating,
    required this.realRating,
    required this.hasRated,
    required this.ratingCount,
    this.favoriteTagIndex,
    this.favoriteTagName,
    required this.favoriteCount,
    required this.language,
    this.uploader,
    required this.publishTime,
    required this.isExpunged,
    required this.tags,
    required this.size,
    required this.torrentCount,
    required this.torrentPageUrl,
    required this.archivePageUrl,
    this.parentGalleryUrl,
    this.childrenGallerys,
    required this.comments,
    required this.thumbnails,
    required this.thumbnailsPageCount,
  });

  Gallery toGallery() {
    return Gallery(
      galleryUrl: galleryUrl,
      title: japaneseTitle ?? rawTitle,
      category: category,
      cover: cover,
      pageCount: pageCount,
      rating: rating,
      hasRated: hasRated,
      favoriteTagIndex: favoriteTagIndex,
      favoriteTagName: favoriteTagName,
      language: language,
      uploader: uploader,
      publishTime: publishTime,
      isExpunged: isExpunged,
      tags: tags,
    );
  }

  @override
  GalleryDetail fromJson(Map<String, dynamic> map) {
    galleryUrl = GalleryUrl.fromJson(map['galleryUrl']);
    rawTitle = map['rawTitle'];
    japaneseTitle = map['japaneseTitle'];
    category = map['category'];
    cover = GalleryImage.fromJson(map['cover']);
    pageCount = map['pageCount'];
    rating = map['rating'];
    realRating = map['realRating'];
    hasRated = map['hasRated'];
    ratingCount = map['ratingCount'];
    favoriteTagIndex = map['favoriteTagIndex'];
    favoriteTagName = map['favoriteTagName'];
    favoriteCount = map['favoriteCount'];
    language = map['language'];
    uploader = map['uploader'];
    publishTime = map['publishTime'];
    isExpunged = map['isExpunged'];
    tags = LinkedHashMap<String, List<GalleryTag>>.from(map['tags']);
    size = map['size'];
    torrentCount = map['torrentCount'];
    torrentPageUrl = map['torrentPageUrl'];
    archivePageUrl = map['archivePageUrl'];
    parentGalleryUrl = map['parentGalleryUrl'];
    childrenGallerys = List<ChildGallery>.from(map['childrenGallerys']);
    comments = List<GalleryComment>.from(map['comments']);
    thumbnails = List<GalleryThumbnail>.from(map['thumbnails']);
    thumbnailsPageCount = map['thumbnailsPageCount'];
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
