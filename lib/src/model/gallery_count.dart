import 'package:get/get.dart';

import 'base_model.dart';

class GalleryCount extends Model<GalleryCount> {
  final String? count;
  final GalleryCountType type;

  GalleryCount({this.count, required this.type});

  String toPrintString() {
    switch (type) {
      case GalleryCountType.accurate:
        return 'accurateCountTemplate'.trArgs([count!]);
      case GalleryCountType.hundreds:
        return 'hundredsOfCountTemplate'.tr;
      case GalleryCountType.thousands:
        return 'thousandsOfCountTemplate'.tr;
    }
  }

  @override
  String toString() {
    return 'GalleryCount{count: $count, type: $type}';
  }

  factory GalleryCount.fromJson(Map<String, dynamic> map) {
    return GalleryCount(
      count: map['count'],
      type: GalleryCountType.values[map['type']],
    );
  }

  @override
  GalleryCount fromJson(Map<String, dynamic> map) {
    return GalleryCount(
      count: map['count'],
      type: GalleryCountType.values[map['type']],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['count'] = count;
    data['type'] = type.index;
    return data;
  }
}

enum GalleryCountType {
  /// 1,465,200
  /// about 232,805
  /// 50,000+
  accurate,

  /// hundreds of
  hundreds,

  /// thousands of
  thousands,
  ;
}
