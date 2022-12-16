
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tmtt/generated/assets.dart';
import 'package:tmtt/src/resources/styles/btn_style.dart';
import 'package:tmtt/src/resources/styles/my_color.dart';
import 'package:tmtt/src/resources/styles/txt_style.dart';
import 'package:tmtt/src/widgets/bottom_button.dart';
import 'package:tmtt/src/widgets/plain_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/write_message/write_message_controller.dart';

class DownloadAdvertiseItem extends GetView<WriteMessageController> {
  const DownloadAdvertiseItem({super.key});


  @override
  Widget build(BuildContext context) {

    return Expanded(
        child: InkWell(
          onTap: () => controller.onClickDownloadButton(),
          child: Container(
            //child: Image.asset(Assets.imagesFeaturedCard)
            height: 300,
            foregroundDecoration: const BoxDecoration(
              image: DecorationImage(
                //image: CachedNetworkImageProvider(controller.promotionImageURL.value))
                  image: AssetImage(Assets.imagesFeaturedCard))
            )
          ),
        )
    );
      // child: Container(
      //   margin: const EdgeInsets.only(top: 18),
      //   padding: const EdgeInsets.all(14),
      //   decoration: BoxDecoration(
      //     color: MyColor.kSecondary,
      //     borderRadius: BorderRadius.circular(24),
      //   ),
      //   child: Column(
      //     children: [
      //       const Spacer(),
      //       Align(
      //         alignment: Alignment.centerLeft,
      //         child: SvgPicture.asset(Assets.imagesGreetingMan),
      //       ),
      //       const Spacer(),
      //       PlainText(
      //         text: "Download the app to\nsend messages with\nmore special features..",
      //         style: MyTextStyle.body1Bold.copyWith(
      //           fontSize: 17,
      //           color: MyColor.white,
      //         ),
      //       ),
      //       const Spacer(),
      //       Align(
      //         alignment: Alignment.centerRight,
      //         child: SvgPicture.asset(Assets.imagesGreetingGirl),
      //       ),
      //       const Spacer(),
      //       BottomPlainButton(
      //         text: 'Get my own message!',
      //         textStyle: MyTextStyle.body2Bold.copyWith(color: MyColor.kPrimary,),
      //         onPressed: () => controller.onClickDownloadButton(),
      //         enabledObs: RxBool(true),
      //         style: BtnStyle.whiteOutlineRadius2,
      //       ),
      //     ],
      //   ),
  }

}