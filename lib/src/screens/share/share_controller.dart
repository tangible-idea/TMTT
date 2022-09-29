
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_insta/flutter_insta.dart';
import 'package:flutter_social_content_share/flutter_social_content_share.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_share/social_share.dart';
import 'package:tmtt/src/screens/base/base_get_controller.dart';
import 'package:tmtt/src/util/my_logger.dart';

class ShareBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShareController());
  }
}

class ShareController extends BaseGetController {

  late final inputController = TextEditingController();

  var textToShare = ''.obs;

  Future<void> shareOnInstagram() async {
    //textToShare.value;

    // final file = await ImagePicker().pickImage(
    //   source: ImageSource.gallery,
    // );
    // SocialShare.shareInstagramStory(
    //   file!.path,
    //   backgroundTopColor: "#ffffff",
    //   backgroundBottomColor: "#000000",
    //   attributionURL: "https://deep-link-url",
    // ).then((data) {
    //   print(data);
    // });

    FlutterSocialContentShare.share(
        type: ShareType.instagramWithImageUrl,
        imageUrl:
        "https://post.healthline.com/wp-content/uploads/2020/09/healthy-eating-ingredients-732x549-thumbnail-732x549.jpg");
    //SocialShare.shareWhatsapp("Hello World");

    // if (GetPlatform.isAndroid) {
    //   AndroidIntent intent = AndroidIntent(
    //     action: 'com.instagram.share.ADD_TO_STORY',
    //     arguments: {'source_application': 'package:link.tmtt.tmtt'},
    //   );
    //   await intent.launch();
    // }

  }

  @override
  void onInit() {

  }

  @override
  void onClose() {

  }

  @override
  void onBackPressed() {

  }

  @override
  void onNextPressed() {

  }

}