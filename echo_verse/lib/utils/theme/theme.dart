import 'package:echo_verse/utils/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'OpenSans',
      textTheme: _textTheme,
      brightness: Brightness.light,
      scaffoldBackgroundColor: white,
      colorScheme: ColorScheme.fromSeed(seedColor: teal),
    );
  }

  static final TextTheme _textTheme = TextTheme(
      headlineLarge: TextStyle(
          
          fontSize: 40.sp,
          fontWeight: FontWeight.w600,
          color: authenticationHeaderlineColor),
      labelMedium: TextStyle(
          fontSize: 16.sp,
          
          fontWeight: FontWeight.w600,
          color: authenticationHeaderlineColor),
      labelSmall: TextStyle(
          fontSize: 15.sp, fontWeight: FontWeight.w400, color: lightGrey));
}
