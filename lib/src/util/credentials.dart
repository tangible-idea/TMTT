


import 'package:tmtt/src/util/local_storage.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseUser;

class Credentials {

  static logout() {
    firebaseUser.FirebaseAuth.instance.signOut();
    LocalStorage.deleteAll();
  }
}