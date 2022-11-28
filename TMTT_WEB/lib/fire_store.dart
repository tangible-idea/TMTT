
import 'dart:io';
import 'dart:typed_data';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import 'constants/firestore_key.dart';
import 'constants/local_storage_key_store.dart';
import 'data/fire_store_collections.dart';
import 'data/hint.dart';
import 'data/message.dart';
import 'data/user.dart';
import 'info_util.dart';
import 'local_storage.dart';
import 'my_logger.dart';


enum LoginUserType {
  google, faceBook, apple, other
}

class FireStore {

  static FirebaseFirestore get instance => FirebaseFirestore.instance;

  static Future<String> register(User user) async {
    // var user = User(
    //   slugId: userId,
    //   userId: userId,
    // );

    var doc = await instance
        .collection(Collections.users)
        .add(user.toJson());

    return doc.id;
  }


  static Future<void> writeMessage({
    required User user,
    required String message,
    required Hint hint,
    int emojiCode = 0
  }) async {

    var data = Message(
      senderDeviceId: await InfoUtil.getUUid(),
      receiveUserId: user.documentId,
      question: user.message,
      message: message,
      emojiCode: emojiCode,
      createDate: DateTime.now().toString(),
      hint: hint,
    );

    await instance
        .collection(Collections.message)
        .add(data.toJson());
  }

  /// update user's field
  static Future<bool> updateUserValue(String key, String value) async {
    var docId = await LocalStorage.get(KeyStore.userDocId, '');
    if (docId.isEmpty) {
      return false;
    }
    await instance
        .collection(Collections.users)
        .doc(docId)
        .update({key: value}).onError((error, stackTrace) =>
    {
      Log.d(error.toString())
    });
    return true;
  }

  static Future<User?> searchUserSocialType(LoginUserType type,
      String userId) async {
    var idKey = 'user_id';
    if (type != LoginUserType.other) {
      idKey = "${type.name.toString()}_uid";
    }

    var snapshot = await instance
        .collection(Collections.users)
        .where(idKey, isEqualTo: userId)
        .get();

    if (snapshot.docs.isEmpty) { // There's no existing user.
      return null;
    }

    var map = snapshot.docs.first.data();
    var user = User.fromJson(map);
    user.documentId = snapshot.docs.first.id;
    return user; // Found a existing user.
  }

  // 해당 숫자만큼 포인트 증가
  static Future<void> increasePointOf(String userSlug, int amount) async {
    var snapshot = await instance
        .collection(Collections.users)
        .where(FireStoreKey.slug_id, isEqualTo: userSlug)
        .get();

    if (snapshot.docs.isEmpty) {
      Log.e("There's no document with corresponding slug_id.");
      return;
    }
    snapshot.docs.first.reference.update(
        {"point": FieldValue.increment(amount)}).then((value) =>
    {
      Log.d("Point increased by $amount Successfully!")
    });
  }

  /// slug_id -> User
  static Future<User?> searchUserSlug(String userSlug) async {
    // var myUID= FireAuth.getMyUID();
    // if(myUID == "") { return null; }

    var snapshot = await instance
        .collection(Collections.users)
        .where(FireStoreKey.slug_id, isEqualTo: userSlug)
        .get();

    if (snapshot.docs.isEmpty) {
      Log.e("There's no document with corresponding slug_id.");
      return null;
    }

    var map = snapshot.docs.first.data();
    var user = User.fromJson(map);
    user.documentId = snapshot.docs.first.id;
    return user;
  }
}