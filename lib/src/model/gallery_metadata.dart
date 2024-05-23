import 'dart:collection';

import 'package:jhentai/src/model/gallery_image.dart';
import 'package:jhentai/src/model/gallery_tag.dart';
import 'package:jhentai/src/model/gallery_url.dart';

import 'base_model.dart';

class GalleryMetadata extends Model<GalleryMetadata> {
  GalleryUrl galleryUrl;
  String archiveKey;
  String title;
  String japaneseTitle;
  String category;
  GalleryImage cover;
  int pageCount;
  double rating;
  String language;

  /// may be null if (Disowned)
  String? uploader;
  String publishTime;
  bool isExpunged;
  String size;
  int torrentCount;

  LinkedHashMap<String, List<GalleryTag>> tags;

  GalleryMetadata({
    required this.galleryUrl,
    required this.archiveKey,
    required this.title,
    required this.japaneseTitle,
    required this.category,
    required this.cover,
    required this.pageCount,
    required this.rating,
    required this.language,
    this.uploader,
    required this.publishTime,
    required this.isExpunged,
    required this.size,
    required this.torrentCount,
    required this.tags,
  });
  
  @override
  GalleryMetadata fromJson(Map<String, dynamic> map) {
    galleryUrl = GalleryUrl.fromJson(map['galleryUrl']);
    archiveKey = map['archiveKey'];
    title = map['title'];
    japaneseTitle = map['japaneseTitle'];
    category = map['category'];
    cover = GalleryImage.fromJson(map['cover']);
    pageCount = map['pageCount'];
    rating = map['rating'];
    language = map['language'];
    uploader = map['uploader'];
    publishTime = map['publishTime'];
    isExpunged = map['isExpunged'];
    size = map['size'];
    torrentCount = map['torrentCount'];
    tags = LinkedHashMap<String, List<GalleryTag>>.from(map['tags'].map((k, v) => MapEntry(k, List<GalleryTag>.from(v.map(GalleryTag.fromJson)))));
    return this;
  }
  
  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['galleryUrl'] = galleryUrl.toJson();
    data['archiveKey'] = archiveKey;
    data['title'] = title;
    data['japaneseTitle'] = japaneseTitle;
    data['category'] = category;
    data['cover'] = cover.toJson();
    data['pageCount'] = pageCount;
    data['rating'] = rating;
    data['language'] = language;
    data['uploader'] = uploader;
    data['publishTime'] = publishTime;
    data['isExpunged'] = isExpunged;
    data['size'] = size;
    data['torrentCount'] = torrentCount;
    data['tags'] = tags.map((k, v) => MapEntry(k, v.map((e) => e.toJson()).toList()));
    return data;
  }
}
