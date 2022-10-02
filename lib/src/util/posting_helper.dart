
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tmtt/src/util/file_manager.dart';
import 'package:tmtt/src/util/image_util.dart';
import 'package:tmtt/src/util/textpainter.dart';

class PostingHelper {

  static const _shareInstaChannel = MethodChannel("link.tmtt/shareinsta");

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static final ImagePicker _imagePicker = ImagePicker();
  static PickedFile? _imageToShare;

  // 인스타에 공유하기
  static Future<String> shareOnInstagram({String message = ''}) async {

    // backgroundVideo = await imagePicker.getVideo(
    //   source: ImageSource.gallery,
    // );

    // Load image from picker
    _imageToShare = await _imagePicker.getImage(
      source: ImageSource.gallery,
    );

    // get path to save image.
    String dirToSave= await _localPath;

    final image = decodeImage(File(_imageToShare!.path).readAsBytesSync())!;


    final painterDesc = CustomTextPainter(message, 60.0, color: 0xFFFFFFFF);
    final imageDesc = await painterDesc.toImageData();
    //final imageOfFont= await painterDesc.toImage();

    List<int>? listFont= imageDesc?.buffer.asUint8List().toList(growable: false);

    // 원본 이미지에 텍스트를 canvas로 그려서 입힌다. (가운데 좌표)
    drawImage(image, decodePng(listFont!)!,
        dstX: image.width~/2 - painterDesc.pictureW~/2 + 30,
        dstY: image.height~/2 - painterDesc.pictureH~/2 + 30,
        dstW: painterDesc.pictureW.toInt(),
        dstH: painterDesc.pictureH.toInt());

    var newFile= await ImageUtils.imageToFile(imageName: 'mytest.png');
    var newImage = decodePng(newFile.readAsBytesSync());
    drawImage(image,  newImage!,
      dstX: image.width~/2 - newImage.width~/2 + 30,
      dstY: image.height~/2 - newImage.height~/2 + 200,);


    //drawString(image, newFont, 0, 0, inputController.text);
    // Save the image to disk as a PNG
    String filePath= '$dirToSave/export.png';
    File(filePath).writeAsBytesSync(encodePng(image));


    Map<String, dynamic> arguments = {
      "imagePath": filePath
    };
    //final String resultFromAndroid= await shareInstaChannel.invokeMethod("sharePhotoToInstagram", arguments);

    final String resultFromAndroid= await _shareInstaChannel.invokeMethod("shareInstagramImageStoryWithSticker", arguments);

    // var context = Get.context;
    // if (context == null) { return; }
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));

    //Log.d(resultFromAndroid);
    return resultFromAndroid;
  }


}