


import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_insta/flutter_insta.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tmtt/firebase/fire_store.dart';
import 'package:tmtt/pages.dart';
import 'package:tmtt/src/constants/local_storage_key_store.dart';
import 'package:tmtt/src/util/local_storage.dart';
import 'package:tmtt/src/util/my_logger.dart';
import 'package:tmtt/src/util/my_navigator.dart';
import 'package:tmtt/data/model/user.dart' as userModel;

import '../../util/my_snackbar.dart';
import '../base/base_get_controller.dart';

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }
}

class RegisterController extends BaseGetController {


  late final slugInputController = TextEditingController();
  var errorObs= Rx<String?>(null);
  @override
  void onInit() {
    slugInputController.addListener(() {
      errorObs.value= null; // 텍스트 수정 시: validation error 없애준다.
    });
  }

  @override
  void onClose() { }

  void goToHome() {
    MyNav.pushReplacementNamed(
      pageName: PageName.home,
    );
  }



  // text error validation
  String? get errorText {
    // at any time, we can get the text from _controller.value.text
    final text = slugInputController.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'The slug can\'t be blank.';
    }
    if (text.length < 4) {
      return 'The slug should be longer than 4 letters.';
    }
    else if (text.length > 16) {
      return 'Your slug is too long :\'(';
    }
    return null;
  }

  // slug 만들기
  void createYourSlug(String slug) async {
    errorObs.value= errorText; // run validation.
    if(errorObs.value != null) return;

    bool isSuccess= await FireStore.updateUserValue("slug_id", slug);
    if(!isSuccess) {
      MySnackBar.show(title: 'Error', message: 'There is an error while creating your slug.');
    } else {
      await LocalStorage.put(KeyStore.userSlugId, slug);
      MyNav.pushReplacementNamed(
        pageName: PageName.home,
      );
    }
  }

  // google API with Firebase
  void signInWithGoogle() async {
    try {
      UserCredential credential= await getCredentialFromGoogleFirebase();
      String uid = credential.user?.uid ?? '';

      String userEmail= credential.user?.email.toString() ?? "";
      MySnackBar.show(title: 'Login', message: userEmail);

      var registerDocId = "";

      var currentUser= await FireStore.searchUserSocialType(LoginUserType.google, uid);
      if(currentUser == null) {
        var user = userModel.User(
          googleUid: credential.user?.uid ?? '',
        );
        registerDocId= await FireStore.register(user); // firestore signing up.
      }else{ // user does exist : get current doc-id.
        registerDocId= currentUser.documentId;
      }

      // await LocalStorage.put(KeyStore.userSlugId, userEmail);
      await LocalStorage.put(KeyStore.userDocId, registerDocId);
      await LocalStorage.put(KeyStore.isLogin, true);

      // TODO: firestore -> slug값이 없으면
      if(currentUser == null) {
        // Go to home
        MyNav.pushReplacementNamed(
          pageName: PageName.createslug,
        );
      }else{
        // Go to home
        //goToHome();
        MyNav.pushReplacementNamed(
          pageName: PageName.createslug,
        );
      }

    }catch(e) {
      MySnackBar.show(title: 'Exception', message: e.toString());

    }
  }


  Future<UserCredential> getCredentialFromGoogleFirebase() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


  // void register() async {
  //   var userId = slugInputController.text;
  //
  //   FlutterInsta flutterInsta = FlutterInsta();
  //   await flutterInsta.getProfileData(userId);
  //   Log.d(
  //       flutterInsta.username + '\n' +
  //           flutterInsta.followers + '\n' +
  //           flutterInsta.following + '\n' +
  //           flutterInsta.imgurl
  //   );
  //
  //   var registerDocId = await FireStore.register(userId);
  //   await LocalStorage.put(KeyStore.userInstagramId, userId);
  //   await LocalStorage.put(KeyStore.userDocId, registerDocId);
  //   await LocalStorage.put(KeyStore.isLogin, true);
  //
  //   Log.d('success register');
  //   MyNav.pushReplacementNamed(
  //     pageName: PageName.home,
  //   );
  // }
}

