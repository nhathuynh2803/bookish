import 'dart:collection';

import 'package:jhentai/src/model/base_model.dart';
import 'package:jhentai/src/model/gallery_image.dart';
import 'package:jhentai/src/model/gallery_tag.dart';
import 'package:jhentai/src/model/gallery_url.dart';

class Gallery extends Model<Gallery> {
  GalleryUrl galleryUrl;
  String title;
  String category;
  GalleryImage cover;

  /// null when in Minimal mode / Favorite tab
  int? pageCount;

  double rating;

  /// unavailable when in ranklist page
  bool hasRated;

  /// unavailable when in ranklist page
  int? favoriteTagIndex;
  String? favoriteTagName;

  /// null when in Minimal mode
  String? language;

  /// null when in Thumbnail mode / Favorite tab / for disowned gallery
  String? uploader;

  String publishTime;
  bool isExpunged;
  LinkedHashMap<String, List<GalleryTag>> tags;

  bool blockedByLocalRules;

  int get gid => galleryUrl.gid;

  String get token => galleryUrl.token;

  bool get isFavorite => favoriteTagIndex != null || favoriteTagName != null;

  Gallery({
    required this.galleryUrl,
    required this.title,
    required this.category,
    required this.cover,
    this.pageCount,
    required this.rating,
    required this.hasRated,
    this.favoriteTagIndex,
    this.favoriteTagName,
    this.language,
    this.uploader,
    required this.publishTime,
    required this.isExpunged,
    required this.tags,
    this.blockedByLocalRules = false,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'gid': gid,
      'token': token,
      'title': title,
      'category': category,
      'cover': cover.toJson(),
      'pageCount': pageCount,
      'rating': rating,
      'hasRated': hasRated,
      'isFavorite': isFavorite,
      'favoriteTagIndex': favoriteTagIndex,
      'favoriteTagName': favoriteTagName,
      'galleryUrl': galleryUrl.url,
      'language': language,
      'uploader': uploader,
      'publishTime': publishTime,
      'isExpunged': isExpunged,
      'tags': tags,
    };
  }

  factory Gallery.fromJson(Map<String, dynamic> map) {
    return Gallery(
      galleryUrl: GalleryUrl.parse(map['galleryUrl']),
      title: map['title'],
      category: map['category'],
      cover: GalleryImage.fromJson(map['cover']),
      pageCount: map['pageCount'],
      rating: map['rating'],
      hasRated: map['hasRated'],
      favoriteTagIndex: map['favoriteTagIndex'],
      favoriteTagName: map['favoriteTagName'],
      language: map['language'],
      uploader: map['uploader'],
      publishTime: map['publishTime'],
      isExpunged: map['isExpunged'] ?? false,
      tags: LinkedHashMap.of(
        (map['tags'] as Map).map(
          (key, value) => MapEntry(
            key,
            (value as List).map((e) => GalleryTag.fromJson(e)).toList(),
          ),
        ),
      ),
    );
  }

  @override
  String toString() {
    return 'Gallery{galleryUrl: $galleryUrl, title: $title, category: $category, cover: $cover, pageCount: $pageCount, rating: $rating, hasRated: $hasRated, favoriteTagIndex: $favoriteTagIndex, favoriteTagName: $favoriteTagName, language: $language, uploader: $uploader, publishTime: $publishTime, isExpunged: $isExpunged, tags: $tags, hasLocalFilteredTag: $blockedByLocalRules}';
  }

  Gallery copyWith({
    GalleryUrl? galleryUrl,
    String? title,
    String? category,
    GalleryImage? cover,
    int? pageCount,
    double? rating,
    bool? hasRated,
    int? favoriteTagIndex,
    String? favoriteTagName,
    String? language,
    String? uploader,
    String? publishTime,
    bool? isExpunged,
    LinkedHashMap<String, List<GalleryTag>>? tags,
    bool? blockedByLocalRules,
  }) {
    return Gallery(
      galleryUrl: galleryUrl ?? this.galleryUrl,
      title: title ?? this.title,
      category: category ?? this.category,
      cover: cover ?? this.cover,
      pageCount: pageCount ?? this.pageCount,
      rating: rating ?? this.rating,
      hasRated: hasRated ?? this.hasRated,
      favoriteTagIndex: favoriteTagIndex ?? this.favoriteTagIndex,
      favoriteTagName: favoriteTagName ?? this.favoriteTagName,
      language: language ?? this.language,
      uploader: uploader ?? this.uploader,
      publishTime: publishTime ?? this.publishTime,
      isExpunged: isExpunged ?? this.isExpunged,
      tags: tags ?? this.tags,
      blockedByLocalRules: blockedByLocalRules ?? this.blockedByLocalRules,
    );
  }
  
  @override
  Gallery fromJson(Map<String, dynamic> map) {
    galleryUrl = GalleryUrl.fromJson(map['galleryUrl']);
    title = map['title'];
    category = map['category'];
    cover = GalleryImage.fromJson(map['cover']);
    pageCount = map['pageCount'];
    rating = map['rating'];
    hasRated = map['hasRated'];
    favoriteTagIndex = map['favoriteTagIndex'];
    favoriteTagName = map['favoriteTagName'];
    language = map['language'];
    uploader = map['uploader'];
    publishTime = map['publishTime'];
    isExpunged = map['isExpunged'];
    tags = LinkedHashMap<String, List<GalleryTag>>.from(map['tags']);
    return this;
  }
}
