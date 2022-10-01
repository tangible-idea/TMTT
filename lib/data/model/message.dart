import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Message {

  String receiveUserId = ''; // 이 메시지를 받는 유저 (document id)
  String question = ''; // 현재 상태 메시지
  String message = ''; // 상태메시지에 남길 익명 메시지
  bool read = false;
  String country = '';
  String location = ''; // 국가
  String sentTime = '';
  String phone = '';
  String platform = '';  // IOS, Android, Window, Mac, Linux
  String carrierIsp = ''; // 통신사
  String createDate = '';
  int emojiCode = 0; // 동물 코드

  Message({
    this.receiveUserId = '',
    this.question = '',
    this.message = '',
    this.read = false,
    this.country = '',
    this.location = '',
    this.sentTime = '',
    this.phone = '',
    this.platform = '',
    this.carrierIsp = '',
    this.createDate = '',
    this.emojiCode = 0,
  });

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);

}

