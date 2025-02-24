import 'package:echo_verse/dependencies/service_locator.dart';
import 'package:echo_verse/features/notification/data/repository/notification_contract_repo.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
    //Get Fcm token
    final token = await firebaseMessaging.getToken();
    debugPrint('FCM Token:$token');
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
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationServices().setupNotificaiton();
  await NotificationServices().showNotification(message);
}
