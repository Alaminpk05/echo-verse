import 'package:echo_verse/app.dart';
import 'package:echo_verse/core/services/objectbox/open_store.dart';
import 'package:echo_verse/features/authentication/data/repository/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

late ObjectBox objectbox;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  objectbox=await ObjectBox.create();

  runApp( MyApp(authContract:AuthService() ,));
}
