
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:tmtt/data/model/message.dart';
import 'package:tmtt/src/util/info_util.dart';
import 'package:tmtt/src/util/my_logger.dart';
import '../data/model/user.dart';
import 'fire_store_collections.dart';

class FireStore {

  static FirebaseFirestore get instance => FirebaseFirestore.instance;

  static Future<String> registerUser(String userId) async {
    var user = User(
      instagramUserId: userId,
      userId: userId,
    );

    var doc = await instance
        .collection(Collections.users)
        .add(user.toJson());

    return doc.id;
  }

  static Future<User?> getUser(String userId) async {

    var snapshot = await instance
        .collection(Collections.users)
        .where('user_id', isEqualTo: userId)
        .get();

    if(snapshot.docs.isEmpty) {
      return null;
    }

    var map = snapshot.docs.first.data();

    return User.fromJson(map);
  }

  static Future<void> writeMessage({
    required User user,
    required String message,
    int emojiCode = 0
  }) async {

    var data = Message(
      receiveUserId: user.userId,
      question: user.message,
      message: message,
      emojiCode: emojiCode,
      platform: InfoUtil.getPlatform(),
      createDate: DateTime.now().toString(),
      location: Get.locale.toString(),
    );

    await instance
        .collection(Collections.message)
        .add(data.toJson());
  }
}
