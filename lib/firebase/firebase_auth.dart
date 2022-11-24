

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../src/util/my_logger.dart';

class FireAuth {

  // sign in via Apple
  Future<UserCredential?> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final authResult = await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      Log.d("Successfully signing with Apple.");
      return authResult;
    } catch(error) {
      Log.d("Error while signing with Apple: $error");
      return null;
    }
  }


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