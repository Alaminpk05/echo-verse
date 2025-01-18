import 'package:echo_verse/features/authentication/registration/screens/registration.dart';
import 'package:echo_verse/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Echo Verse',
        theme: AppTheme.lightTheme,
        home: RegistrationPage(),
      );
      },
    );
  }
}
