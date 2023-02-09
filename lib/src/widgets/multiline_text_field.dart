
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tmtt/src/resources/styles/txt_style.dart';

import '../resources/styles/my_color.dart';

class MultiLineTextField extends StatelessWidget {

  final String? hintText;
  final int maxLength;
  final int maxLine;
  final TextEditingController? controller;
  final Function(String text)? onChanged;
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  final FocusNode? focusNode;
  final bool? filled;
  final TextInputType? keyboardType;

  MultiLineTextField({
    Key? key,
    required this.maxLength,
    required this.maxLine,
    this.hintText,
    this.onChanged,
    this.controller,
    this.textAlign,
    this.textStyle,
    this.focusNode,
    this.filled,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: false,
      maxLines: maxLine,
      cursorColor: MyColor.kPrimary,
      style: textStyle ?? MyTextStyle.formInputBig,
      keyboardType: keyboardType ?? TextInputType.multiline,
      maxLength: maxLength,
      textAlign: textAlign ?? TextAlign.left,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      onChanged: (text) {
        if(onChanged != null) {
          onChanged!(text);
        }
      },
      focusNode: focusNode,
      decoration: InputDecoration(
        filled: filled,
        fillColor: MyColor.kGrey5,
        focusedBorder: plainOutlineInputBorder(),
        enabledBorder: plainOutlineInputBorder(),
        hintText: hintText ?? '',
        hintStyle: textStyle ?? MyTextStyle.formInputBig,
        counterText:'',
      ),
    );
  }

  OutlineInputBorder plainOutlineInputBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(
        color: MyColor.kGrey5,
        width: 0.1,
      ),
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
    );
  }
}
