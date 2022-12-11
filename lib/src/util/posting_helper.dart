
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'dart:ui' as ui;

import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tmtt/firebase/fire_store.dart';
import 'package:tmtt/src/resources/styles/my_color.dart';
import 'package:tmtt/src/util/file_manager.dart';
import 'package:tmtt/src/util/image_util.dart';
import 'package:tmtt/src/util/textpainter.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import 'package:http/http.dart' as http;

import '../../data/model/user.dart';
import 'my_snackbar.dart';

extension on String {
  List<String> splitByLength(int length) =>
      [substring(0, length), substring(length)];
}

class PostingHelper {

  static const _shareInstaChannel = MethodChannel("link.tmtt/shareinsta");

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // 인스타에 공유하기
  static Future<String> shareOnInstagram({String message = '', required User myinfo, Uint8List? profileImageBytes}) async {

    // get path to save image.
    String dirToSave= await _localPath;

    // Load story background image.
    File backgroundImage= await ImageUtils.imageToFile(imageName: 'background5_2.png');
    final image = decodeImage(backgroundImage.readAsBytesSync())!;

    // Text를 이미지로 전환한다.
    final painterDesc = CustomTextPainter(message, 60.0, color: MyColor.kGrey1);
    final imageDesc = await painterDesc.toImageData();
    //final imageOfFont= await painterDesc.toImage();

    List<int>? listFont= imageDesc?.buffer.asUint8List().toList(growable: false);

    const onCenter= false;
    if(onCenter) {
      // 원본 이미지에 텍스트를 canvas로 그려서 입힌다. (가운데 좌표)
      drawImage(image, decodePng(listFont!)!,
          dstX: image.width~/2 - painterDesc.pictureW~/2 + 30,
          dstY: image.height~/2 - painterDesc.pictureH~/2 - 325,
          dstW: painterDesc.pictureW.toInt(),
          dstH: painterDesc.pictureH.toInt());
    }else{
      // 원본 이미지에 텍스트를 canvas로 그려서 입힌다. (가운데 좌표)
      drawImage(image, decodePng(listFont!)!,
          dstX: 150,
          dstY: 510,
          dstW: painterDesc.pictureW.toInt(),
          dstH: painterDesc.pictureH.toInt());
    }

    // Load character image.
    var randomInt= Random().nextInt(2)+1;
    File characterFile= await ImageUtils.imageToFile(imageName: 'character_cat_$randomInt.png');
    final characterImage = decodeImage(characterFile.readAsBytesSync())!;

    drawImage(image, characterImage,
        dstX: 0,
        dstY: 800,
        dstW: characterImage.width.toInt(),
        dstH: characterImage.height.toInt());

    // Load profile image. if it exists.
    if(profileImageBytes != null) {
      final profileImage = decodeImage(profileImageBytes)!;
      drawImage(image, profileImage,
          dstX: 630,
          dstY: 325,
          dstW: profileImage.width.toInt() ~/ 3,
          dstH: profileImage.height.toInt() ~/ 3);
    }

    if(profileImageBytes != null) {
      drawString(image, arial_24, 630, 300, "@${myinfo.slugId}");
    }
    else { // without profile photo
      drawString(image, arial_24, 630, 400, "@${myinfo.slugId}");
    }

    // Save the image to disk as a PNG
    String filePath= '$dirToSave/export.png';
    File(filePath).writeAsBytesSync(encodePng(image));


    Map<String, dynamic> arguments = {
      "imagePath": filePath,
      "link": "https://tmtt.link/#/${myinfo.slugId}"
    };
    //final String resultFromAndroid= await shareInstaChannel.invokeMethod("sharePhotoToInstagram", arguments);

    final String resultFromNative= await _shareInstaChannel.invokeMethod("shareInstagramImageStoryWithSticker", arguments);

    // var context = Get.context;
    // if (context == null) { return; }
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));

    //Log.d(resultFromAndroid);
    return resultFromNative;
  }


  // 인스타에 공유하기
  static Future<String> shareOnInstagramReply(Uint8List imageBytes) async {

    // get path to save image.
    String dirToSave= await _localPath;

    // Load story background image.
    var backgroundImage= await ImageUtils.imageToFile(imageName: 'background7.png');
    final decodedBackgroundImage = decodeImage(File(backgroundImage.path).readAsBytesSync())!;
    final decodedAnswerImage= decodeImage(imageBytes)!;

    const onCenter= true;
    if(onCenter) {
      double fScale= 3.0;
      int targetW= decodedAnswerImage.width.toInt()~/fScale;
      int targetH= decodedAnswerImage.height.toInt()~/fScale;

      // 원본 이미지에 텍스트를 canvas로 그려서 입힌다. (가운데 좌표)
      drawImage(decodedBackgroundImage, decodedAnswerImage,
          dstX: decodedBackgroundImage.width ~/ 2 - targetW~/2,
          dstY: decodedBackgroundImage.height ~/ 2 - targetH~/2,
          dstW: targetW,
          dstH: targetH);
    }

    // Save the image to disk as a PNG
    String filePath= '$dirToSave/export.png';
    File(filePath).writeAsBytesSync(encodePng(decodedBackgroundImage));

    Map<String, dynamic> arguments = {
      "imagePath": filePath
    };
    final String resultFromNative= await _shareInstaChannel.invokeMethod("shareInstagramImageStoryWithSticker", arguments);

    return resultFromNative;
  }


}