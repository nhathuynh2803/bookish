import 'package:jhentai/src/exception/internal_exception.dart';

import 'base_model.dart';

class GalleryImagePageUrl extends Model<GalleryImagePageUrl> {
  final bool isEH;

  final String imageToken;

  final int gid;

  final int pageNo;

  GalleryImagePageUrl({
    required this.isEH,
    required this.gid,
    required this.imageToken,
    required this.pageNo,
  }) : assert(imageToken.length == 10);

  static GalleryImagePageUrl? tryParse(String url) {
    RegExp regExp = RegExp(r'https://e([-x])hentai\.org/s/([a-z0-9]{10})/(\d+)-(\d+)');
    Match? match = regExp.firstMatch(url);
    if (match == null) {
      return null;
    }

    return GalleryImagePageUrl(
      isEH: match.group(1) == '-',
      imageToken: match.group(2)!,
      gid: int.parse(match.group(3)!),
      pageNo: int.parse(match.group(4)!),
    );
  }

  static GalleryImagePageUrl parse(String url) {
    GalleryImagePageUrl? galleryImagePageUrl = tryParse(url);

    if (galleryImagePageUrl == null) {
      throw InternalException(message: 'Parse gallery image page url failed, url:$url');
    }
    return galleryImagePageUrl;
  }

  String get url => isEH ? 'https://e-hentai.org/s/$imageToken/$gid-$pageNo' : 'https://exhentai.org/s/$imageToken/$gid-$pageNo';

  factory GalleryImagePageUrl.fromJson(Map<String, dynamic> map) {
    return GalleryImagePageUrl(
      isEH: map['isEH'],
      imageToken: map['imageToken'],
      gid: map['gid'],
      pageNo: map['pageNo'],
    );
  }

  @override
  GalleryImagePageUrl fromJson(Map<String, dynamic> map) {
    return GalleryImagePageUrl(
      isEH: map['isEH'],
      imageToken: map['imageToken'],
      gid: map['gid'],
      pageNo: map['pageNo'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isEH'] = isEH;
    data['imageToken'] = imageToken;
    data['gid'] = gid;
    data['pageNo'] = pageNo;
    return data;
  }
}
