import 'package:json_annotation/json_annotation.dart';

import 'hint.dart';

part 'message.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Message {

  String docId = ''; // doc id
  String senderDeviceId = ''; // uuid
  String receiveUserId = ''; // 이 메시지를 받는 유저 (document id)
  String question = ''; // 현재 상태 메시지
  String message = ''; // 상태메시지에 남길 익명 메시지
  bool read = false;
  String createDate = '';
  int emojiCode = 0; // 동물 코드
  Hint hint = Hint();

  Message({
    this.docId = '',
    this.senderDeviceId = '',
    this.receiveUserId = '',
    this.question = '',
    this.message = '',
    this.read = false,
    this.createDate = '',
    this.emojiCode = 0,
    required this.hint
  });

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

