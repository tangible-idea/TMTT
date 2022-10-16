
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tmtt/src/resources/styles/txt_style.dart';

import '../resources/styles/my_color.dart';

class PrefixInputField extends StatelessWidget {

  final TextEditingController controller;
  final String? hintText;
  final int? maxLength;
  final TextInputType? keyboardType;
  final bool? isObscure;
  final Function(String text)? onChanged;
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  final FocusNode? focusNode;

  // prefix string
  final String? prefixString;

  // error validation condition.
  final String? errorValidation;

  PrefixInputField({
    Key? key,
    required this.controller,
    this.hintText,
    this.keyboardType,
    this.maxLength,
    this.isObscure,
    this.onChanged,
    this.textAlign,
    this.textStyle,
    this.focusNode,
    this.prefixString,
    this.errorValidation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObscure ?? false,
      style: textStyle ?? MyTextStyle.formInput,
      keyboardType: keyboardType ?? TextInputType.text,
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
        filled: true,
        fillColor: MyColor.bg03,
        focusedBorder: plainOutlineInputBorder(),
        enabledBorder: plainOutlineInputBorder(),
        hintText: hintText ?? '',
        hintStyle: MyTextStyle.formInput.copyWith(
          color: MyColor.typo01,
        ),
        counterText:'',
        prefixIcon: const Padding(
          padding: EdgeInsets.fromLTRB(20,0,0,0),
          child: Text('https://tmtt.link/'),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        errorText: errorValidation,
        errorBorder: plainOutlineInputBorder(borderColor : MyColor.point02),
        focusedErrorBorder: plainOutlineInputBorder(borderColor : MyColor.point02),
      ),
    );
  }



  OutlineInputBorder plainOutlineInputBorder({Color? borderColor}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor ?? MyColor.gray_02,
        width: 1.2,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    );
  }
}
