
import 'package:json_annotation/json_annotation.dart';

part 'hint.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Hint {

  String country = '';
  String city = ''; // 국가
  String phone = '';
  String platform = '';  // IOS, Android, Window, Mac, Linux
  String carrierIsp = ''; // 통신사

  Hint({
    this.country = '',
    this.city = '',
    this.phone = '',
    this.platform = '',
    this.carrierIsp = '',
  });

  factory Hint.fromJson(Map<String, dynamic> json) => _$HintFromJson(json);
  Map<String, dynamic> toJson() => _$HintToJson(this);
}
