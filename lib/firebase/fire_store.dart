
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:tmtt/data/model/hint.dart';
import 'package:tmtt/data/model/message.dart';
import 'package:tmtt/src/constants/local_storage_keys.dart';
import 'package:tmtt/src/util/info_util.dart';
import 'package:tmtt/src/util/local_storage.dart';
import 'package:tmtt/src/util/my_logger.dart';
import '../data/model/user.dart';
import 'fire_store_collections.dart';

class FireStore {

  static FirebaseFirestore get instance => FirebaseFirestore.instance;

  static Future<String> register(String userId) async {
    var user = User(
      instagramUserId: userId,
      userId: userId,
    );

    var doc = await instance
        .collection(Collections.users)
        .add(user.toJson());

    return doc.id;
  }

  static Future<User?> getMyInfo() async {
    var docId = await LocalStorage.get(Keys.userDocId, '');
    if (docId.isEmpty) { return null; }
    var snapshot = await instance
        .collection(Collections.users)
        .doc(docId)
        .get();
    var data = snapshot.data();
    if (data == null) { return null; }
    return User.fromJson(data);
  }

  /// update user's field
  static Future<bool> updateUserValue(String key, String value) async {
    var docId = await LocalStorage.get(Keys.userDocId, '');
    if (docId.isEmpty) { return false; }
    await instance
        .collection(Collections.users)
        .doc(docId)
        .update({key: value}).onError((error, stackTrace) => {
          Log.d(error.toString())
    });
    return true;
  }

  static Future<void> editMySateMessage(String message) async {
    var docId = await LocalStorage.get(Keys.userDocId, '');
    if (docId.isEmpty) { return; }
    await instance
        .collection(Collections.users)
        .doc(docId)
        .update({'message': message});
  }


  static Future<User?> searchUser(String userId) async {

    var snapshot = await instance
        .collection(Collections.users)
        .where('user_id', isEqualTo: userId)
        .get();

    if(snapshot.docs.isEmpty) {
      return null;
    }

    var map = snapshot.docs.first.data();
    var user = User.fromJson(map);
    user.documentId = snapshot.docs.first.id;
    return user;
  }

  static Future<void> writeMessage({
    required User user,
    required String message,
    int emojiCode = 0
  }) async {

    var data = Message(
      senderDeviceId: await InfoUtil.getUUid(),
      receiveUserId: user.documentId,
      question: user.message,
      message: message,
      emojiCode: emojiCode,
      createDate: DateTime.now().toString(),
      hint: await InfoUtil.getHint(),
    );

    await instance
        .collection(Collections.message)
        .add(data.toJson());
  }

  static Future<List<Message>> getMyMessages() async {
    var docId = await LocalStorage.get(Keys.userDocId, '');
    var snapshot = await instance
        .collection(Collections.message)
        .where('receive_user_id', isEqualTo: docId)
        .get();
    var messages = <Message>[];
    for (var doc in snapshot.docs) {
      var data = Message.fromJson(doc.data());
      data.docId = doc.id;
      messages.add(data);
    }
    messages.sort((a, b) => b.createDate.compareTo(a.createDate));
    return messages;
  }

  static Future<void> updateReadState(String docId) async {
    await instance
        .collection(Collections.message)
        .doc(docId)
        .update({'read': true});
  }
}
