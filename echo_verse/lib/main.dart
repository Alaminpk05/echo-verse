import 'package:echo_verse/app_view.dart';
import 'package:echo_verse/core/services/objectbox/open_store.dart';
import 'package:flutter/material.dart';

late ObjectBox objectbox;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  objectbox=await ObjectBox.create();

  runApp(const MyApp());
}
