import 'package:echo_verse/featurse/authentication/registration/screens/registration.dart';
import 'package:echo_verse/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Echo Verse',
      theme: AppTheme.lightTheme,
      home: RegistrationPage(),
    );
  }
}