import 'base_model.dart';
import 'gallery_hh_archive.dart';

class GalleryHHInfo extends Model<GalleryHHInfo>{
  int? gpCount;
  int? creditCount;
  List<GalleryHHArchive> archives;

  GalleryHHInfo({
    this.gpCount,
    this.creditCount,
    required this.archives,
  });
  
  @override
  GalleryHHInfo fromJson(Map<String, dynamic> map) {
    gpCount = map['gpCount'];
    creditCount = map['creditCount'];
    archives = List<GalleryHHArchive>.from(map['archives'].map(GalleryHHArchive.fromJson));
    return this;
  }
  
  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['gpCount'] = gpCount;
    data['creditCount'] = creditCount;
    data['archives'] = archives.map((e) => e.toJson()).toList();
    return data;
  }
}
