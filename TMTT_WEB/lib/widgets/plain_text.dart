

import 'package:flutter/material.dart';

import '../constants/txt_style.dart';

class PlainText extends StatelessWidget {

  String? text;
  TextAlign? align;
  TextStyle? style;

  double? marginTop;
  double? marginBottom;
  double? marginLeft;
  double? marginRight;

  double? paddingTop;
  double? paddingBottom;
  double? paddingLeft;
  double? paddingRight;

  PlainText({
    this.text,
    this.align,
    this.style,
    this.marginTop,
    this.marginBottom,
    this.marginLeft,
    this.marginRight,
    this.paddingTop,
    this.paddingBottom,
    this.paddingLeft,
    this.paddingRight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: paddingTop ?? 0,
        bottom: paddingBottom ?? 0,
        left: paddingLeft ?? 0,
        right: paddingRight ?? 0,
      ),
      margin: EdgeInsets.only(
        top: marginTop ?? 0,
        bottom: marginBottom ?? 0,
        left: marginLeft ?? 0,
        right: marginRight ?? 0,
      ),
      child: Text(
          text ?? "",
          textAlign: align ?? TextAlign.left,
          style: style ?? MyTextStyle.body1
      ),
    );
  }
}