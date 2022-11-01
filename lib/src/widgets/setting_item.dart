

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
  final Icon? icon;

  SettingItem({
    Key? key,
    this.title,
    this.subtitle,
    this.icon,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: MyColor.kLightBackground,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(children: [
          AppSpaces.horizontalSpace20,
          const CircleAvatar(radius: 22,
              backgroundColor: MyColor.white,),
          AppSpaces.horizontalSpace10,
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