
import 'dart:io';

import 'package:tmtt/src/util/my_logger.dart';

class FileManager {

  /// 이미지 프로세싱 후, 필요 없어진 파일을 삭제하기.
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