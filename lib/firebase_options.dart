// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBuhgwdGwDKeJb-ThEUK5Vqibn43Qhpm8k',
    appId: '1:982782530678:web:5f8fac77aa1d671b0a3b57',
    messagingSenderId: '982782530678',
    projectId: 'ttmt-56b3b',
    authDomain: 'ttmt-56b3b.firebaseapp.com',
    storageBucket: 'ttmt-56b3b.appspot.com',
    measurementId: 'G-8Q21B16TVV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDGi6cg2SpmVeX2Rb8XamAwEw39R9PU6MU',
    appId: '1:982782530678:android:141972985f0489ae0a3b57',
    messagingSenderId: '982782530678',
    projectId: 'ttmt-56b3b',
    storageBucket: 'ttmt-56b3b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA2nVvbiwJq3uZwjI8TSlNvSHCm0ioNN20',
    appId: '1:982782530678:ios:79e75d969560dad40a3b57',
    messagingSenderId: '982782530678',
    projectId: 'ttmt-56b3b',
    storageBucket: 'ttmt-56b3b.appspot.com',
    iosClientId: '982782530678-8fsv5nsslfd1p9ttffmdpu6lm9qnl18k.apps.googleusercontent.com',
    iosBundleId: 'link.tmtt.tmtt',
  );
}