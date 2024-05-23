import 'base_model.dart';

class GalleryNote extends Model<GalleryNote> {
  final String note;

  GalleryNote({required this.note});

  @override
  GalleryNote fromJson(Map<String, dynamic> map) {
    return GalleryNote(
      note: map['note'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['note'] = note;
    return data;
  }
}
