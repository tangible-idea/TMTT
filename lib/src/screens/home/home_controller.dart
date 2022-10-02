

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_insta/flutter_insta.dart';
import 'package:get/get.dart';
import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tmtt/data/model/message.dart';
import 'package:tmtt/data/model/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tmtt/firebase/fire_store.dart';
import 'package:tmtt/src/constants/URLs.dart';
import 'package:tmtt/src/screens/base/base_get_controller.dart';
import 'package:tmtt/src/screens/home/home_fragment.dart';
import 'package:tmtt/src/screens/home/inbox_fragment.dart';
import 'package:tmtt/src/screens/home/setting_fragment.dart';
import 'package:tmtt/src/util/info_util.dart';
import 'package:tmtt/src/util/my_logger.dart';
import 'package:flutter/services.dart';

import '../../util/textpainter.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}


class HomeController extends BaseGetController {

  @override
  void onInit() {

  }

  @override
  void onClose() {
    inputController.dispose();
    messageInputController.dispose();
  }

  var currentIndexObs = 0.obs;

  List<Widget> pages = [
    HomeFragment(),
    InboxFragment(),
    SettingFragment(),
  ];

  List<String> pageTitles = [
    'home',
    'inbox',
    'setting',
  ];

  // 이미지 고르기
  ImagePicker imagePicker = ImagePicker();
  PickedFile? backgroundVideo;
  PickedFile? imageToShare;

  late final inputController = TextEditingController();
  late final messageInputController = TextEditingController();

  var userNameObs = ''.obs;
  var deviceInfoObs = ''.obs;
  var myInfoObs = User().obs;
  var myLinkObs = ''.obs;
  var messagesObs = <Message>[].obs;

  static const shareInstaChannel= MethodChannel("link.tmtt/shareinsta");


  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }


  // 인스타에 공유하기
  Future<void> shareOnInstagram(BuildContext context) async {

    // backgroundVideo = await imagePicker.getVideo(
    //   source: ImageSource.gallery,
    // );

    // Load image from picker
    imageToShare = await imagePicker.getImage(
      source: ImageSource.gallery,
    );

    // get path to save image.
    String dirToSave= await _localPath;

    final image = decodeImage(File(imageToShare!.path).readAsBytesSync())!;


    final painterDesc = CustomTextPainter(messageInputController.text, 60.0, color: 0xFFFFFFFF);
    final imageDesc = await painterDesc.toImageData();
    //final imageOfFont= await painterDesc.toImage();

    List<int>? listFont= imageDesc?.buffer.asUint8List().toList(growable: false);

    // 원본 이미지에 텍스트를 canvas로 그려서 입힌다. (가운데 좌표)
    drawImage(image, decodePng(listFont!)!,
        dstX: image.width~/2 - painterDesc.pictureW~/2 + 30,
        dstY: image.height~/2 - painterDesc.pictureH~/2 + 30,
        dstW: painterDesc.pictureW.toInt(),
        dstH: painterDesc.pictureH.toInt());


    //drawString(image, newFont, 0, 0, inputController.text);
    // Save the image to disk as a PNG
    String filePath= '$dirToSave/export.png';
    File(filePath).writeAsBytesSync(encodePng(image));


    Map<String, dynamic> arguments = {
      "imagePath": filePath
    };
    //final String resultFromAndroid= await shareInstaChannel.invokeMethod("sharePhotoToInstagram", arguments);

    final String resultFromAndroid= await shareInstaChannel.invokeMethod("shareInstagramImageStoryWithSticker", arguments);
    //Log.d(resultFromAndroid);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(resultFromAndroid)));
  }

  void searchInstaUser() async {
    String userName = inputController.text;
    Log.d(userName);

    FlutterInsta flutterInsta = FlutterInsta();
    await flutterInsta.getProfileData(userName); //instagram username

    String a = inputController.text;
    Log.d(a);
    userNameObs.value = flutterInsta.bio;

    Log.d(
      flutterInsta.username + '\n' +
      flutterInsta.followers + '\n' +
      flutterInsta.following + '\n' +
      flutterInsta.imgurl
    );
  }

  Future<void> getMyInfo() async {
    var myInfo = await FireStore.getMyInfo();
    if (myInfo == null) { return; }
    messageInputController.text = myInfo.message;
    userNameObs.value = myInfo.userId;
    myLinkObs.value = '${Urls.baseUrl}#/${myInfo.userId}';
    myInfoObs.value = myInfo;
  }

  Future<void> editMyMessage() async {
    var text = messageInputController.text;
    if(text.isEmpty) { return; }
    await FireStore.editMyMessage(text);
    Get.snackbar("edit success!", "");
    myInfoObs.value.message = text;
  }

  Future<void> copyMyLink() async {
    Clipboard.setData(ClipboardData(text: myLinkObs.value));
    Get.snackbar("copy success!", "");
  }

  void getDeviceInfoTest() async {
    deviceInfoObs.value = await InfoUtil.getAllDeviceInfo();
  }

  void getMyMessages() async {
    var message = await FireStore.getMyMessages();
    messagesObs.value = message;
    Log.d(message);
  }

  void registerUser() {

  }

  @override
  void onBackPressed() {

  }

  @override
  void onNextPressed() {

  }

}
