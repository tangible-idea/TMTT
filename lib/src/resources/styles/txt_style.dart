import 'package:flutter/material.dart';

enum TextType {
  h1,           // 제목 h1
  h2,           // 제목 h2
  h3,           // 제목 h3
  h4,           // 제목 h4
  subTitle1,    // 부제목 1
  subTitle2,    // 부제목 2
  body1,        // 본문 텍스트 표준 크기
  body1Bold,    // 본문 텍스트 표준 크기 (굵은 서체)
  body2,        // 작은 본문 텍스트 표준 크기
  body2Bold,    // 작은 본문 텍스트 표준 크기  (굵은 서체)
  caption1,     // 보조 구문
  caption1Bold, // 보조 구문 (굵은 서체)
  caption2,     // 더 작은 보조 구문
  caption2Bold, // 더 작은 보조 구문  (굵은 서체)
  btn1,         // 버튼명
  btn2,         // 조금 더 작은 버튼명
  formLabel,    // 서식 레이블
  formInput1,   // 서식 입력구문 1
  formInput2,   // 조금 더 큰 서식 입력구문
  formHelper,   // 서식 도움말
  toast,        // 토스트 메시지
  title,        // 팝업 타이틀
  contents,     // 팝업 콘텐츠 내용
}

class MyTextStyle {
  static const TextStyle h1 = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w500,
    fontFamily: 'Notosans',
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w500,
    fontFamily: 'Notosans',
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    fontFamily: 'Notosans',
  );

  static const TextStyle h4 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    fontFamily: 'Notosans',
  );

  static const TextStyle subTitle1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: 'Notosans',
  );

  static const TextStyle subTitle2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    fontFamily: 'Notosans',
  );

  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: 'Notosans',
  );

  static const TextStyle body1Bold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontFamily: 'Notosans',
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: 'Notosans',
  );

  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: 'Notosans',
  );

  static const TextStyle body2Bold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    fontFamily: 'Notosans',
  );

  static const TextStyle caption1 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: 'Notosans',
  );

  static const TextStyle caption1Bold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    fontFamily: 'Notosans',
  );

  static const TextStyle caption2 = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    fontFamily: 'Notosans',
  );

  static const TextStyle caption2Bold = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    fontFamily: 'Notosans',
  );

  static const TextStyle btn1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: 'Notosans',
  );

  static const TextStyle btn2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: 'Notosans',
  );

  static const TextStyle formLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: 'Notosans',
  );

  static const TextStyle formInput = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: 'Notosans',
  );

  static const TextStyle formInput2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    fontFamily: 'Notosans',
  );

  static const TextStyle formHelper = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    fontFamily: 'Notosans',
  );

  static const TextStyle toast = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: 'Notosans',
  );

  static const TextStyle title = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontFamily: 'Notosans',
  );

  static const TextStyle contents = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: 'Notosans',
  );
}