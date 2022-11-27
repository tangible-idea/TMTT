
import 'package:json_annotation/json_annotation.dart';

// run 'flutter pub run build_runner watch' in terminal

part 'hint.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Hint {

  String country = '';
  String city = ''; // 국가
  String device = '';
  String uuid = '';
  String os = '';
  String platform = '';  // IOS, Android, Window, Mac, Linux
  String carrierIsp = ''; // 통신사

  Hint({
    this.country = '',
    this.city = '',
    this.device = '',
    this.uuid = '',
    this.os = '',
    this.platform = '',
    this.carrierIsp = '',
  });

  factory Hint.fromJson(Map<String, dynamic> json) => _$HintFromJson(json);
  Map<String, dynamic> toJson() => _$HintToJson(this);
}
