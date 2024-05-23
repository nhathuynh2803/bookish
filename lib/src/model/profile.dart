import 'package:jhentai/src/model/base_model.dart';

class Profile  extends Model<Profile>{
  int number;

  String name;

  bool selected;

  Profile({required this.number, required this.name, required this.selected});
  
  @override
  Profile fromJson(Map<String, dynamic> map) {
    number = map['number'];
    name = map['name'];
    selected = map['selected'];
    return this;
  }
  
  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['number'] = number;
    data['name'] = name;
    data['selected'] = selected;
    return data;
  }
}
