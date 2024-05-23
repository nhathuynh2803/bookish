import 'package:jhentai/src/model/base_model.dart';

class SearchHistory extends Model<SearchHistory> {
  String rawKeyword;
  String? translatedKeyword;

  SearchHistory({
    required this.rawKeyword,
    this.translatedKeyword,
  });
  
  @override
  SearchHistory fromJson(Map<String, dynamic> map) {
    rawKeyword = map['rawKeyword'];
    translatedKeyword = map['translatedKeyword'];
    return this;
  }
  
  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['rawKeyword'] = rawKeyword;
    data['translatedKeyword'] = translatedKeyword;
    return data;
  }
}
