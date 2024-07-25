import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FCMService {
  final fcm = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await fcm.setAutoInitEnabled(true);
    await fcm.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);

    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final fcmToken = await fcm.getToken();
    print('Push Notification: $fcmToken');

    initPushNotifications();
  }

  Future<void> initPushNotifications() async {
    //fcm.getInitialMessage().then(handleMessage);

    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
      if (remoteMessage.notification != null) {
        print(
            'Message also contained  a notifcation: ${remoteMessage.notification}');
        print('Message Title: ${remoteMessage.notification!.title}');
        print('Message Body: ${remoteMessage.notification!.body}');
      }
    });
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage remoteMessage) async {
  print("Handling a background message: ${remoteMessage.messageId}");
}


//f-zElj-ESAuyFERIO4q1Vf:APA91bEJoJ8as13eFfqWsw85rVm29erZMeqyu1HF7qHiGELC74oQi6SUR5-JPPQazj9nNpzZPaTgN0Ye-CzwnZPjXI5YBQ9SHmHzTD1ErmzhHeqA3BvvUvUa2iZuLq_zLmfa7mMPwzsA