


import 'package:tmtt/src/util/inapp_purchase_util.dart';
import 'package:tmtt/src/util/local_storage.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseUser;

class Credentials {

  static Future<void> logout() async {
    await firebaseUser.FirebaseAuth.instance.signOut();
    LocalStorage.deleteAll();
    await Purchase.logout();
  }
}