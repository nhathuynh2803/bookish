import 'package:jhentai/src/model/gallery_count.dart';

import 'base_model.dart';
import 'gallery.dart';

enum FavoriteSortOrder { favoritedTime, publishedTime }

class GalleryPageInfo extends Model<GalleryPageInfo> {
  final GalleryCount? totalCount;

  final FavoriteSortOrder? favoriteSortOrder;

  final List<Gallery> gallerys;

  final String? prevGid;

  final String? nextGid;

  GalleryPageInfo({
    required this.gallerys,
    this.favoriteSortOrder,
    this.totalCount,
    this.prevGid,
    this.nextGid,
  });
  
  @override
  GalleryPageInfo fromJson(Map<String, dynamic> map) {
    return GalleryPageInfo(
      totalCount: map['totalCount'] == null ? null : GalleryCount.fromJson(map['totalCount']),
      favoriteSortOrder: map['favoriteSortOrder'],
      gallerys: List<Gallery>.from(map['gallerys'].map(Gallery.fromJson)),
      prevGid: map['prevGid'],
      nextGid: map['nextGid'],
    );
  }
  
  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['totalCount'] = totalCount?.toJson();
    data['favoriteSortOrder'] = favoriteSortOrder;
    data['gallerys'] = gallerys.map((e) => e.toJson()).toList();
    data['prevGid'] = prevGid;
    data['nextGid'] = nextGid;
    return data;
  }
}
