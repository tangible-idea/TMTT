

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tmtt/src/resources/styles/txt_style.dart';
import 'package:tmtt/src/widgets/app_space.dart';
import 'package:tmtt/src/widgets/plain_text.dart';

import '../../generated/assets.dart';
import '../resources/styles/my_color.dart';

class SettingItem extends StatelessWidget {

  final String? title;
  final String? subtitle;
  final IconData? icon;

  SettingItem({
    Key? key,
    this.title,
    this.subtitle,
    this.icon,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: MyColor.kLightBackground,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(children: [
          AppSpaces.horizontalSpace20,
            Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle
              ),
              child: Icon(
                icon,
                color: MyColor.kPrimary,
              ),
            ),

          AppSpaces.horizontalSpace10,
          AppSpaces.horizontalSpace5,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            PlainText(text: title, style: MyTextStyle.body16bold),
            PlainText(text: subtitle, style: MyTextStyle.body14subtitle)
          ],),
          const Spacer(),
          SvgPicture.asset(Assets.imagesIcoArrowRight),
          AppSpaces.horizontalSpace20,
        ],),
      ),
    );
  }
}