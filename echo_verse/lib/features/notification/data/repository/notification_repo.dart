import 'dart:convert';
import 'package:echo_verse/dependencies/service_locator.dart';
import 'package:echo_verse/features/notification/data/repository/notification_contract_repo.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:googleapis_auth/auth_io.dart';

class NotificationServices implements NotificationContractRepo {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Future<void> requestPermission() async {
    await firebaseMessaging.requestPermission();
  }

  Future<void> initialize() async {
    await requestPermission();
    await setupMessageHandler();
    await updateFcmToken();
  }

  Future<void> setupNotificaiton() async {
    /// ANDROID SETUP
    const channel = AndroidNotificationChannel(
        'android_channel_id', 'Android Channel',
        description: 'This is description of android notification channel',
        importance: Importance.high);
    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    ///IOS SETUP
    const iosSettings = DarwinInitializationSettings();

    final initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await notificationsPlugin.initialize(initSettings,
        onDidReceiveNotificationResponse: (value) {});
  }

  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      await notificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails('id', 'name',
                  channelDescription: 'Channel description',
                  importance: Importance.high,
                  priority: Priority.high,
                  icon: '@mipmap/ic_launcher'),
              iOS: const DarwinNotificationDetails()),
          payload: message.data.toString());
    }
  }

  Future<void> setupMessageHandler() async {
    //foreground message
    FirebaseMessaging.onMessage.listen((message) {
      showNotification(message);
    });
    // background message
    FirebaseMessaging.onMessageOpenedApp.listen(handleBackgroundMessege);
    //opened app
    final initialMessage = await firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      handleBackgroundMessege(initialMessage);
    }
  }

  void handleBackgroundMessege(RemoteMessage message) {
    if (message.data['type'] == 'chat') {
      //open chat screen
    }
  }

  Future<void> sendPushNotification(
      String token, String senderName, String message) async {
    try {
      final String? projectId = dotenv
          .env['FIREBASE_PROJECT_ID']; // Change to your Firebase Project ID
      final String fcmUrl =
          "https://fcm.googleapis.com/v1/projects/$projectId/messages:send";

      // Load the service account credentials
      final serviceAccountPath = dotenv.env['SERVICE_ACCOUNT_PATH'];
      final serviceAccount =
          jsonDecode(await rootBundle.loadString(serviceAccountPath!));

      // Authenticate using OAuth 2.0
      final credentials = ServiceAccountCredentials.fromJson(serviceAccount);
      final client = await clientViaServiceAccount(
          credentials, ['https://www.googleapis.com/auth/firebase.messaging']);

      // Define the notification payload
      final body = {
        "message": {
          "token": token,
          "notification": {"title": senderName, "body": message},
          "data": {
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
            "senderName": senderName,
            "message": message
          }
        }
      };
      debugPrint(token);
      
      // Send the HTTP POST request to Firebase
      final response = await client.post(
        Uri.parse(fcmUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        debugPrint("Push notification sent successfully via HTTP v1 API.");
      } else {
        debugPrint("Error sending push notification: ${response.body}");
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  Future<void> updateFcmToken() async {
    //Get Fcm token
    final String? token = await firebaseMessaging.getToken();
    if (token != null && userUid != null) {
      await firestore
          .collection('users')
          .doc(userUid)
          .update({'pushToken': token});
    }
    debugPrint('FCM Token:$token');
    debugPrint('User Uid:$userUid');
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationServices().setupNotificaiton();
  await NotificationServices().showNotification(message);
}
