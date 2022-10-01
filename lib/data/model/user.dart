import 'package:json_annotation/json_annotation.dart';

// run 'flutter pub run build_runner watch' in terminal

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class User {

  String instagramUserId = '';
  String instagramProfileImage = '';
  int signature = 0;
  String userId = '';
  String bio = '';
  bool premiumUser = false;
  int credit = 0;
  String registerDate = '';
  String pushToken = '';
  String message = '';

  User({
    this.instagramUserId = '',
    this.instagramProfileImage = '',
    this.signature = 0,
    this.userId = '',
    this.bio = '',
    this.premiumUser = false,
    this.credit = 0,
    this.registerDate = '',
    this.pushToken = '',
    this.message = '',
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

}