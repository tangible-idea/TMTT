


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_insta/flutter_insta.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tmtt/firebase/fire_store.dart';
import 'package:tmtt/pages.dart';
import 'package:tmtt/src/bottom_dialog/found_instagram_account_dialog.dart';
import 'package:tmtt/src/constants/local_storage_key_store.dart';
import 'package:tmtt/src/util/inapp_purchase_util.dart';
import 'package:tmtt/src/util/local_storage.dart';
import 'package:tmtt/src/util/my_dialog.dart';
import 'package:tmtt/src/util/my_logger.dart';
import 'package:tmtt/src/util/my_navigator.dart';
import 'package:tmtt/data/model/user.dart' as userModel;

import '../../resources/languages/strings.dart';
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
  var instagramFoundObs= Rx<bool>(false);

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
  List<String> blockList = [
    "splash",
    "register",
    "createslug",
    "home",
    "inbox",
    "privacy"
  ];

  bool instagramIDMatchRegex(String value) {
    String pattern = r'(^[\w](?!.*?\.{2})[\w.]{1,28}[\w]$)';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;

  }

  // slug 만들기
  void createYourSlug(String slug) async {
    errorObs.value= errorText; // run validation.
    if(errorObs.value != null) return; // return on validation error.
    if(blockList.contains(slug)) return; // (주의) 슬러그가 페이지명과 겹치면 안된다.

    var trimmedSlug= slug.trim();

    // 이미 내가 사용하고 있다면 그냥 넘어감. (일어날 확률이 드문 예외처리)
    var myInfo= await FireStore.getMyInfo();
    if(myInfo?.slugId == trimmedSlug) {
      goToHome();
      return;
    }

    // 유저 검색.
    var userSlug= await FireStore.searchUserSlug(trimmedSlug);
    if(userSlug != null) {
      errorObs.value= Strings.slugCreateError1.tr;
      return;
    }

    // instagram ID 형식과 똑같이 검사한다.
    var isFormatValidForSlug= instagramIDMatchRegex(trimmedSlug);
    if(!isFormatValidForSlug) {
      errorObs.value= Strings.slugCreateError2.tr;
      return;
    }

    bool isSuccess= await FireStore.updateUserValue("slug_id", trimmedSlug);
    if(!isSuccess) {
      MySnackBar.show(title: 'Error', message: 'There is an error while creating your slug.');
    } else { // success
      searchInstagramAccount(trimmedSlug);
    }
  }

  // find corresponding Instargram id.
  void searchInstagramAccount(String userId) async {
    FlutterInsta flutterInsta = FlutterInsta();

    try {
      await flutterInsta.getProfileData(userId); // try getting instagram account.
      // Log.d("Found account: " +
      //     flutterInsta.username + '\n' +
      //     flutterInsta.followers.toString() + '\n' +
      //     flutterInsta.following + '\n' +
      //     flutterInsta.imgurl
      // );

      if (flutterInsta.username.toString().isNotEmpty) {
        showFoundInstagramAccountByBottomSheet(userId, flutterInsta);
      } else {
        await LocalStorage.put(KeyStore.userSlugId, userId);
        goToHome();
      }
    }on NoSuchMethodError catch (_, ex) {
      await LocalStorage.put(KeyStore.userSlugId, userId);
      goToHome();
    }on Exception catch (_, ex) {
      await LocalStorage.put(KeyStore.userSlugId, userId);
      goToHome();
    }
  }

  // Populate bottom sheet.
  void showFoundInstagramAccountByBottomSheet(String slug, FlutterInsta foundInsta) {

    var dialog= FoundInstagramAccountDialog(
      follower: foundInsta.followers.toString(),
      following: foundInsta.following.toString(),
      instagramId: foundInsta.username.toString(),
      instagramName: foundInsta.fullname.toString(),
      instagramBio: foundInsta.bio.toString(),
      instagramImageURL: foundInsta.imgurl.toString(),
      onYesPressed: () async {
        var isSuccess= await FireStore.linkMyPhotoFromInstagramAccountToStorage(foundInsta.imgurl.toString());
        goToHome();
      },
      onNoPressed: () {
        //goToHome();
      },
    );
    MyDialog.showBottom(
      widget: dialog,
      isEnableDrag: true,
      isFullScreen: false,
    );
  }


  Future<void> saveIdAndGoToHome() async {

    MyNav.pushReplacementNamed(
      pageName: PageName.home,
    );
  }

  // google API with Firebase
  void signInWithGoogle() async {
    try {
      UserCredential credential= await getCredentialFromGoogleFirebase();

      // get uid, email, username
      String uid = credential.user?.uid ?? '';
      String userEmail= credential.user?.email.toString() ?? "";
      String userName= credential.user?.displayName.toString() ?? "";
      MySnackBar.show(title: 'Login', message: userEmail);

      var registerDocId = "";

      var currentUser= await FireStore.searchUserSocialType(LoginUserType.google, uid);
      if(currentUser == null) {

        // get push token
        final fcmToken = await FirebaseMessaging.instance.getToken();

        // create a model and register with the data.
        var user = userModel.User(
          googleUid: credential.user?.uid ?? '',
          registerDate: DateTime.now().toString(),
          pushToken: fcmToken.toString(),
        );
        registerDocId= await FireStore.register(user); // firestore signing up.
      }else{
        registerDocId= currentUser.documentId; // user does exist : get current doc-id.
      }

      await LocalStorage.put(KeyStore.userDocId, registerDocId);
      await LocalStorage.put(KeyStore.isLogin, true);

      // Save your document id itself
      await FireStore.updateUserValue('document_id', registerDocId);

      // set purchase data
      await Purchase.login(registerDocId);
      await Purchase.setUserEmail(userEmail);
      await Purchase.setUserName(userName);

      // check current users slug.
      var myInfo= await FireStore.getMyInfo();
      //var slugId= await LocalStorage.get(KeyStore.userSlugId, '');
      if(myInfo?.slugId != null && myInfo?.slugId.isNotEmpty == true) {
        // Go to home
        goToHome();
      }else{
        // Go to slug creation page.
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

