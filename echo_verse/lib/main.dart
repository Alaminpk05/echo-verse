import 'package:echo_verse/app.dart';
import 'package:echo_verse/dependencies/service_locator.dart';
import 'package:echo_verse/features/notification/data/repository/notification_repo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupServiceLocator();
  await NotificationServices().initialize();

  runApp(MyApp());
}
