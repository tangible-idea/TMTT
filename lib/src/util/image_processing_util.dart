
import 'dart:io';

import 'package:flutter_native_image/flutter_native_image.dart';

import 'my_logger.dart';

class ImageProcessing {

  static Future<File> resizeSmallImage(File file, int width) async {
    ImageProperties properties = await FlutterNativeImage.getImageProperties(file.path);
    File compressedFile = await FlutterNativeImage.compressImage(
        file.path,
        quality: 70,
        percentage: 70,
        targetWidth: width,
        targetHeight: (properties.height! * width / properties.width!).round() // 가로 사이즈와 비율 맞추며 높이 리사이징
    );

    return compressedFile;
  }


  // crop 4:3 (w800 x h600)
  // crop 4:3 (w640 x h480)
  static Future<File> resizeImageForProfile(File file) async {

    // var setWidth = 800;
    // var setHeight = 600;
    var setWidth = 640;
    var setHeight = 480;

    ImageProperties properties = await FlutterNativeImage.getImageProperties(file.path);
    File compressedFile = await FlutterNativeImage.compressImage(
        file.path,
        quality: 70,
        percentage: 70,
        targetWidth: setWidth,
        targetHeight: (properties.height! * setWidth / properties.width!).round() // 가로 사이즈와 비율 맞추며 높이 리사이징
    );

    ImageProperties compressedProperties = await FlutterNativeImage.getImageProperties(compressedFile.path);

    int centerX = (compressedProperties.height! / 2).round();
    int targetCenterY = centerX - (setHeight / 2).round();

    File croppedFile = await FlutterNativeImage.cropImage(
        compressedFile.path,
        0,
        targetCenterY,
        compressedProperties.width!,
        setHeight
    );

    ImageProperties croppedProp = await FlutterNativeImage.getImageProperties(croppedFile.path);
    deleteFile(File(file.path));
    deleteFile(compressedFile);
    Log.d(''
        'croppedFile: $croppedFile\n'
        'path: ${croppedFile.path}\n'
        'width: ${croppedProp.width}\n'
        'height: ${croppedProp.height}'
    );

    return croppedFile;
  }

  static Future<void> deleteFile(File file) async {
    try {
      if (await file.exists()) {
        Log.d('deleted file: ${file.path}');
        await file.delete();
      } else {
        Log.d('file not exist: ${file.path}');
      }
    } catch (e) {
      Log.d(''
          'delete fail: ${file.path}\n'
          'Error in getting access to the file: $e'
      );
    }
  }

}