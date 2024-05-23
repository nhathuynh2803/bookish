import 'base_model.dart';

class GalleryArchive extends Model<GalleryArchive> {
  int? gpCount;
  int? creditCount;

  String originalCost;
  String originalSize;
  String downloadOriginalHint;

  String? resampleCost;
  String? resampleSize;
  String downloadResampleHint;

  GalleryArchive({
    this.gpCount,
    this.creditCount,
    required this.originalCost,
    required this.originalSize,
    required this.downloadOriginalHint,
    this.resampleCost,
    this.resampleSize,
    required this.downloadResampleHint,
  });
  
  @override
  GalleryArchive fromJson(Map<String, dynamic> map) {
    gpCount = map['gpCount'];
    creditCount = map['creditCount'];
    originalCost = map['originalCost'];
    originalSize = map['originalSize'];
    downloadOriginalHint = map['downloadOriginalHint'];
    resampleCost = map['resampleCost'];
    resampleSize = map['resampleSize'];
    downloadResampleHint = map['downloadResampleHint'];
    return this;
  }
  
  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['gpCount'] = gpCount;
    data['creditCount'] = creditCount;
    data['originalCost'] = originalCost;
    data['originalSize'] = originalSize;
    data['downloadOriginalHint'] = downloadOriginalHint;
    data['resampleCost'] = resampleCost;
    data['resampleSize'] = resampleSize;
    data['downloadResampleHint'] = downloadResampleHint;
    return data;
  }
}
