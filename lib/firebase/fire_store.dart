
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tmtt/data/model/hint.dart';
import 'package:tmtt/data/model/message.dart';
import 'package:tmtt/data/model/user.dart';
import 'package:tmtt/firebase/firebase_auth.dart';
import 'package:tmtt/src/constants/local_storage_key_store.dart';
import 'package:tmtt/src/util/image_processing_util.dart';
import 'package:tmtt/src/util/info_util.dart';
import 'package:tmtt/src/util/local_storage.dart';
import 'package:tmtt/src/util/my_logger.dart';

import '../src/constants/firestore_key.dart';
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
  static Future<bool> linkMyPhotoFromInstagramAccountToStorage(String instagramImageURL) async {

    var myUID= FireAuth.getMyUID();
    if(myUID == "") { return false; }

    instagramImageURL= instagramImageURL.replaceFirst("https%3A//", "https://");

    try {
      final response = await http.get(Uri.parse(instagramImageURL));
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        Uint8List bodyBytes = response.bodyBytes;
        String tempPath = (await getTemporaryDirectory()).path;
        File file = await File('$tempPath/my_instagram_image.png').writeAsBytes(bodyBytes);

        var isSuccess= await uploadMyPhotoToStorage(file.path);
        return isSuccess;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load image from instagram.');
      }
    } on FirebaseException catch (e) {
      MySnackBar.show(title: 'Error', message: 'Error on while uploading your picture.');
      return false;
    } on Exception catch (ex) {
      MySnackBar.show(title: 'Error', message: ex.toString());
      return false;
    }
  }

  // My instagram photo to Firebase storage.
  static Future<bool> uploadMyPhotoToStorage(String filepath) async {

    var myUID= FireAuth.getMyUID();
    if(myUID == "") { return false; }

    // Create a Reference to the file
    Reference ref = FirebaseStorage.instance.ref()
        .child('profile')
        .child(myUID)
        .child('/image_${DateTime.now().millisecondsSinceEpoch}');

    try {
      // resize and upload to Stoarge
      File file = File(filepath);
      File resizedImage= await ImageProcessing.resizeSmallImage(file, 300);
      await ref.putFile(resizedImage);

      // update user database on Firestore
      String profileURL= await ref.getDownloadURL();
      await FireStore.updateUserValue(FireStoreKey.profile_image, profileURL);
      await CachedNetworkImage.evictFromCache(profileURL);
      return true;

    } on FirebaseException catch (e) {
      MySnackBar.show(title: 'Error', message: 'Error on while uploading your picture.');
      return false;
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

  static Future<User?> getSomeonesInfo(String docId) async {
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
  static Future<bool> updateUserValue(String key, dynamic value) async {
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

  static Future<void> editMyLastMessage(String message) async {
    var docId = await LocalStorage.get(KeyStore.userDocId, '');
    if (docId.isEmpty) { return; }
    await instance
        .collection(Collections.users)
        .doc(docId)
        .update({'message': message});
  }


  static Future<User?> searchUserSocialType(LoginUserType type, String userId) async {

    var idKey = 'user_id';
    if(type != LoginUserType.other) {
      idKey = "${type.name.toString()}_uid";
    }

    var snapshot = await instance
        .collection(Collections.users)
        .where(idKey, isEqualTo: userId)
        .get();

    if(snapshot.docs.isEmpty) { // There's no existing user.
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

    if(snapshot.docs.isEmpty) {
      Log.e("There's no document with corresponding slug_id.");
      return;
    }
    snapshot.docs.first.reference.update({"point": FieldValue.increment(amount)}).then((value) => {
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

    if(snapshot.docs.isEmpty) {
      Log.e("There's no document with corresponding slug_id.");
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

  static QueryDocumentSnapshot<Map<String, dynamic>>? lastVisibleInbox;
  static Future<List<Message>> getMyMessagesFirst() async {
    lastVisibleInbox = null;
    var docId = await LocalStorage.get(KeyStore.userDocId, '');
    var snapshot = await instance
        .collection(Collections.message)
        .where('receive_user_id', isEqualTo: docId)
        .orderBy('create_date', descending: true)
        .limit(10)
        .get();
    lastVisibleInbox = snapshot.docs.last;
    var messages = <Message>[];
    for (var doc in snapshot.docs) {
      var data = Message.fromJson(doc.data());
      data.docId = doc.id;
      messages.add(data);
    }
    return messages;
  }

  static Future<List<Message>?> getMyMessagesNext() async {
    if(lastVisibleInbox == null) {
      return null;
    }
    var docId = await LocalStorage.get(KeyStore.userDocId, '');
    var snapshot = await instance
        .collection(Collections.message)
        .where('receive_user_id', isEqualTo: docId)
        .orderBy('create_date', descending: true)
        .startAfterDocument(lastVisibleInbox!)
        .limit(10)
        .get();

    if(snapshot.docs.isEmpty) return null;

    lastVisibleInbox = snapshot.docs.last;
    var messages = <Message>[];
    for (var doc in snapshot.docs) {
      var data = Message.fromJson(doc.data());
      data.docId = doc.id;
      messages.add(data);
    }
    // messages.sort((a, b) => b.createDate.compareTo(a.createDate));
    return messages;
  }


  static Future<void> updateReadState(String docId) async {
    await instance
        .collection(Collections.message)
        .doc(docId)
        .update({'read': true});
  }
}
