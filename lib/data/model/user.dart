import 'package:json_annotation/json_annotation.dart';

// run 'flutter pub run build_runner watch' in terminal

part 'user.g.dart';

class UserAccountStatus {
  static const dropout = 0; // 탈퇴
  static const active = 1 ; // 활성화
  static const dormant = 2; // 휴면
}

@JsonSerializable(fieldRename: FieldRename.snake)
class User {

  String slugId = '';
  String profileImage = '';
  int signature = 0; // unique number
  String userId = '';
  String bio = '';
  bool premiumUser = false;
  int credit = 0;
  int status = UserAccountStatus.active;
  String registerDate = '';
  String pushToken = '';
  String message = '';
  String documentId = '';
  String googleUid = '';
  String facebookUid = '';
  String appleUid = '';

  User({
    this.slugId = '',
    this.profileImage = '',
    this.signature = 0,
    this.userId = '',
    this.bio = '',
    this.premiumUser = false,
    this.credit = 0,
    this.status = UserAccountStatus.active,
    this.registerDate = '',
    this.pushToken = '',
    this.message = '',
    this.documentId = '',
    this.googleUid = '',
    this.facebookUid = '',
    this.appleUid = '',
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

}