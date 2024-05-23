import 'package:jhentai/src/model/base_model.dart';

class GalleryHHArchive extends Model<GalleryHHArchive> {
  /// 1280x、Original
  final String resolutionDesc;

  /// 1280、org
  final String? resolution;

  final String size;

  final String cost;

  GalleryHHArchive({
    required this.resolutionDesc,
    this.resolution,
    required this.size,
    required this.cost,
  });

  factory GalleryHHArchive.fromJson(Map<String, dynamic> map) {
    return GalleryHHArchive(
      resolutionDesc: map['resolutionDesc'],
      resolution: map['resolution'],
      size: map['size'],
      cost: map['cost'],
    );
  }

  @override
  GalleryHHArchive fromJson(Map<String, dynamic> map) {
    return GalleryHHArchive(
      resolutionDesc: map['resolutionDesc'],
      resolution: map['resolution'],
      size: map['size'],
      cost: map['cost'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['resolutionDesc'] = resolutionDesc;
    data['resolution'] = resolution;
    data['size'] = size;
    data['cost'] = cost;
    return data;
  }
}
