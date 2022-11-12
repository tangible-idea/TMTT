

import 'package:firebase_auth/firebase_auth.dart';

class FireAuth {


// get login info.
  static String getMyUID() {
    var currUser = FirebaseAuth.instance.currentUser;
    if (currUser == null) {
      return "";
    } else {
      return currUser.uid;
    }
  }
}