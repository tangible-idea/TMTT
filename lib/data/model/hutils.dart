
import 'package:json_annotation/json_annotation.dart';

part 'hutils.g.dart';

@JsonSerializable()
class HUtils {

  String city;
  String isp;
  String country;

  HUtils({
    this.city = '',
    this.isp = '',
    this.country = '',
  });

  factory HUtils.fromJson(Map<String, dynamic> json) => _$HUtilsFromJson(json);
  Map<String, dynamic> toJson() => _$HUtilsToJson(this);
}
