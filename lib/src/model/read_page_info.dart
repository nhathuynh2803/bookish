import 'package:jhentai/src/model/base_model.dart';

import 'gallery_image.dart';

enum ReadMode { downloaded, online, archive, local }

class ReadPageInfo extends Model<ReadPageInfo> {
  ReadMode mode;

  /// null for local gallery
  int? gid;

  /// null for local gallery
  String? token;

  String galleryTitle;

  String? galleryUrl;

  int initialIndex;

  int currentImageIndex;

  int pageCount;

  /// used for archive
  bool isOriginal;

  String readProgressRecordStorageKey;

  /// used for archive&local
  List<GalleryImage>? images;

  /// used for initialize
  bool useSuperResolution;

  ReadPageInfo({
    required this.mode,
    this.gid,
    this.token,
    required this.galleryTitle,
    this.galleryUrl,
    required this.initialIndex,
    required this.pageCount,
    this.isOriginal = false,
    required this.readProgressRecordStorageKey,
    this.images,
    required this.useSuperResolution,
  }) : currentImageIndex = initialIndex;
  
  @override
  ReadPageInfo fromJson(Map<String, dynamic> map) {
     
    mode = ReadMode.values[map['mode']];
    gid = map['gid'];
    token = map['token'];
    galleryTitle = map['galleryTitle'];
    galleryUrl = map['galleryUrl'];
    initialIndex = map['initialIndex'];
    currentImageIndex = map['currentImageIndex'];
    pageCount = map['pageCount'];
    isOriginal = map['isOriginal'];
    readProgressRecordStorageKey = map['readProgressRecordStorageKey'];
    images = List<GalleryImage>.from(map['images'].map(GalleryImage.fromJson));
    useSuperResolution = map['useSuperResolution'];
    return this;

  }
  
  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['mode'] = mode.index;
    data['gid'] = gid;
    data['token'] = token;
    data['galleryTitle'] = galleryTitle;
    data['galleryUrl'] = galleryUrl;
    data['initialIndex'] = initialIndex;
    data['currentImageIndex'] = currentImageIndex;
    data['pageCount'] = pageCount;
    data['isOriginal'] = isOriginal;
    data['readProgressRecordStorageKey'] = readProgressRecordStorageKey;
    data['images'] = images?.map((e) => e.toJson()).toList();
    data['useSuperResolution'] = useSuperResolution;
    return data;
  }
}
