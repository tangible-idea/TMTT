
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tmtt/generated/assets.dart';
import 'package:tmtt/src/resources/my_images.dart';

import '../../resources/styles/my_color.dart';
import '../../resources/styles/txt_style.dart';

class BaseAppBar extends StatelessWidget {

  String? title;

  Color? titleColor;
  Color? backgroundColor;

  bool? useBackButton;
  bool? useCancelButton;

  VoidCallback? onBackPressed;
  VoidCallback? onCancelPressed;

  BaseAppBar({
    this.title,
    this.titleColor,
    this.backgroundColor,
    this.useBackButton,
    this.useCancelButton,
    this.onBackPressed,
    this.onCancelPressed,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if(useBackButton ?? false) backButton() else emptySpace(),
          const Spacer(),
          Text(
            title ?? "",
            style: MyTextStyle.h4.copyWith(
                color: titleColor ?? MyColor.primary_05
            ),
          ),
          const Spacer(),
          if(useCancelButton ?? false) cancelButton() else emptySpace(),
          // Image.asset(ResImg.backIcon),
        ],
      ),
    );
  }

  Widget emptySpace() {
    return Container(
      height: 50,
      width: 55,
    );
  }

  Widget backButton() {
    return Container(
      margin: const EdgeInsets.only(left: 7),
      child: IconButton(
          onPressed: () {
            onBackPressed?.call();
          },
          padding: const EdgeInsets.all(0),
          icon: SvgPicture.asset(Assets.imagesBackArrow)
      ),
    );
  }

  Widget cancelButton() {
    return Container(
      margin: const EdgeInsets.only(right: 7),
      child: IconButton(
          onPressed: () {
            onCancelPressed?.call();
          },
          padding: const EdgeInsets.all(0),
          icon: SvgPicture.asset(MyImages.cancel)
      ),
    );
  }
}

