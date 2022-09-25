
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/model/user.dart';
import 'fire_store_collections.dart';

class FireStore {

  static FirebaseFirestore get instance => FirebaseFirestore.instance;

  static Future<String> registerUser(String userId) async {
    var user = User(
      instagramUserId: userId,
    );
    var doc = await instance
        .collection(Collections.users)
        .add(user.toJson());

    return doc.id;
  }
}