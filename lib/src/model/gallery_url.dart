import 'package:jhentai/src/exception/internal_exception.dart';

import 'base_model.dart';

class GalleryUrl extends Model<GalleryUrl> {
  final bool isEH;

  final int gid;

  final String token;

  GalleryUrl({required this.isEH, required this.gid, required this.token}) : assert(token.length == 10);

  static GalleryUrl? tryParse(String url) {
    RegExp regExp = RegExp(r'https://e([-x])hentai\.org/g/(\d+)/([a-z0-9]{10})');
    Match? match = regExp.firstMatch(url);
    if (match == null) {
      return null;
    }

    return GalleryUrl(
      isEH: match.group(1) == '-',
      gid: int.parse(match.group(2)!),
      token: match.group(3)!,
    );
  }

  static GalleryUrl parse(String url) {
    RegExp regExp = RegExp(r'https://e([-x])hentai\.org/g/(\d+)/([a-z0-9]{10})');
    Match? match = regExp.firstMatch(url);
    if (match == null) {
      throw InternalException(message: 'Parse gallery url failed, url:$url');
    }

    return GalleryUrl(
      isEH: match.group(1) == '-',
      gid: int.parse(match.group(2)!),
      token: match.group(3)!,
    );
  }

  String get url => isEH ? 'https://e-hentai.org/g/$gid/$token/' : 'https://exhentai.org/g/$gid/$token/';

  GalleryUrl copyWith({
    bool? isEH,
    int? gid,
    String? token,
  }) {
    return GalleryUrl(
      isEH: isEH ?? this.isEH,
      gid: gid ?? this.gid,
      token: token ?? this.token,
    );
  }

  @override
  String toString() {
    return 'GalleryUrl{isEH: $isEH, gid: $gid, token: $token}';
  }

  factory GalleryUrl.fromJson(Map<String, dynamic> map) {
    return GalleryUrl(
      isEH: map['isEH'],
      gid: map['gid'],
      token: map['token'],
    );
  }

  @override
  GalleryUrl fromJson(Map<String, dynamic> map) {
    return GalleryUrl(
      isEH: map['isEH'],
      gid: map['gid'],
      token: map['token'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isEH'] = isEH;
    data['gid'] = gid;
    data['token'] = token;
    return data;
  }
}
