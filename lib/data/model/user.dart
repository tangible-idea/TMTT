import 'package:json_annotation/json_annotation.dart';

// run 'flutter pub run build_runner watch' in terminal

part 'user.g.dart';

enum UserAccountStatus {
  dropped(0), // 탈퇴
  activated(1), // 활성화 됨
  inactivated(2); // 휴면
  final int value;
  const UserAccountStatus(this.value);
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
  int status = UserAccountStatus.activated.value;
  String registerDate = '';
  String pushToken = '';
  String message = '';
  String documentId = '';
  String googleUid = '';
  String facebookUid = '';
  String appleUid = '';
  int point= 0;

  User({
    this.slugId = '',
    this.profileImage = '',
    this.signature = 0,
    this.userId = '',
    this.bio = '',
    this.premiumUser = false,
    this.credit = 0,
    this.status = 1,
    this.registerDate = '',
    this.pushToken = '',
    this.message = '',
    this.documentId = '',
    this.googleUid = '',
    this.facebookUid = '',
    this.appleUid = '',
    this.point= 0,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

}