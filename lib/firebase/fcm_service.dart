


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tmtt/firebase/fire_store.dart';
import 'package:tmtt/src/util/my_logger.dart';

class FcmService {

  static get _fcm => FirebaseMessaging.instance;

  static Future<String?> get token => _fcm.getToken();

  static Future<void> init() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    Log.d('Handling a background message: ${message.messageId}');
  }

  static void setPushMessageListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Log.d('Got a message whilst in the foreground!');
      Log.d('Message data: ${message.data}');

      if (message.notification != null) {
        Log.d('''
        Message also contained a notification: ${message.notification}
        title: ${message.notification?.title}
        body:${ message.notification?.body}
        ''');
      }
    });
  }

  static void setPushTokenListener() async {

    var newToken = await token;
    Log.d('newToken: $newToken');

    // send token to application server.
    // Note: This callback is fired at each app startup and whenever a new token is generated.
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
      await FireStore.updateUserValue("push_token", fcmToken);
      Log.d("newPushToken: $fcmToken");
    }).onError((err) {
      Log.e(err); // Error getting token.
    });
  }



}