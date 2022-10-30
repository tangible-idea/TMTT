
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tmtt/data/model/hint.dart';
import 'package:tmtt/data/model/message.dart';
import 'package:tmtt/data/model/user.dart';
import 'package:tmtt/firebase/firebase_auth.dart';
import 'package:tmtt/src/constants/local_storage_key_store.dart';
import 'package:tmtt/src/util/info_util.dart';
import 'package:tmtt/src/util/local_storage.dart';
import 'package:tmtt/src/util/my_logger.dart';

import '../src/util/my_snackbar.dart';
import 'fire_store_collections.dart';

import 'package:http/http.dart' as http;


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

  // instagram photo url -> Firebase Storage
  static Future<void> linkMyPhotoFromInstagramAccountToStorage(String instagramImageURL) async {

    var myUID= FireAuth.getMyUID();
    if(myUID == "") { return; }

    // Create a Reference to the file
    Reference ref = FirebaseStorage.instance.ref()
        .child('profile')
        .child('/image_$myUID');

    try {
      http.get(Uri(path: instagramImageURL)).then((response) async {
        Uint8List bodyBytes = response.bodyBytes;
        var file= await File('my_instagram_image.jpg').writeAsBytes(bodyBytes);
        await ref.putFile(file);
      });
    } on FirebaseException catch (e) {
      MySnackBar.show(title: 'Error', message: 'Error on while uploading your picture.');
    }
  }

  static Future<void> uploadMyPhotoToStorage(String filepath) async {

    var myUID= FireAuth.getMyUID();
    if(myUID == "") { return; }

    // Create a Reference to the file
    Reference ref = FirebaseStorage.instance.ref()
        .child('profile')
        .child('/image_$myUID');

    try {
      File file = File(filepath);
      await ref.putFile(file);
    } on FirebaseException catch (e) {
      MySnackBar.show(title: 'Error', message: 'Error on while uploading your picture.');
    }
  }

  static Future<User?> getMyInfo() async {
    var docId = await LocalStorage.get(KeyStore.userDocId, '');
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
    var docId = await LocalStorage.get(KeyStore.userDocId, '');
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
    var docId = await LocalStorage.get(KeyStore.userDocId, '');
    if (docId.isEmpty) { return; }
    await instance
        .collection(Collections.users)
        .doc(docId)
        .update({'message': message});
  }


  static Future<User?> searchUserSocialType(LoginUserType type, String userId) async {

    var idKey = 'user_id';
    if(type == LoginUserType.google) {
      idKey = 'google_uid';
    }

    var snapshot = await instance
        .collection(Collections.users)
        .where(idKey, isEqualTo: userId)
        .get();

    if(snapshot.docs.isEmpty) {
      return null;
    }

    var map = snapshot.docs.first.data();
    var user = User.fromJson(map);
    user.documentId = snapshot.docs.first.id;
    return user;
  }

  /// slug_id -> User
  static Future<User?> searchUserSlug(String userSlug) async {

    var snapshot = await instance
        .collection(Collections.users)
        .where('slug_id', isEqualTo: userSlug)
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
    var docId = await LocalStorage.get(KeyStore.userDocId, '');
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
