
import 'package:flutter/material.dart';
import 'package:tmtt/src/resources/styles/my_color.dart';
import 'package:tmtt/src/widgets/plain_text.dart';

import '../../resources/styles/txt_style.dart';

class BottomDialogContainer extends StatelessWidget {

  Widget child;
  BoxDecoration? decoration;

  BottomDialogContainer({
    Key? key,
    this.decoration,
    required this.child,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          decoration: (decoration != null) ? decoration : null,
          margin: EdgeInsets.only(top: 14, left: 24, right: 24, bottom: 14),
          child: child,
        ),
      ),
    );
  }
}

class DialogContainer extends StatelessWidget {

  String title;
  String content;
  Widget child;

  TextAlign? align;

  DialogContainer({
    Key? key,
    this.align,
    required this.title,
    required this.content,
    required this.child,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.all(8),
      contentPadding: const EdgeInsets.all(8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      title: Center(
        child: PlainText(
          marginTop: 24,
          marginLeft: 14,
          marginRight: 14,
          marginBottom: 8,
          text: title,
          style: MyTextStyle.body1Bold.copyWith(color: MyColor.typo04),
        ),
      ),
      content: PlainText(
        marginLeft: 14,
        marginRight: 14,
        text: content,
        style: MyTextStyle.body2.copyWith(color: MyColor.typo04),
        align: align,
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(left: 7, right: 7, bottom: 8),
          child: child,
        )
      ],
    );
  }
}
