import 'package:echo_verse/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        fontFamily: 'OpenSans',
        textTheme: _textTheme,
        brightness: Brightness.light,
        scaffoldBackgroundColor: white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: teal,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 8.w),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(36.sp)),
          backgroundColor: teal,
        )),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
             
                alignment: Alignment.topLeft,
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h))),
        bottomNavigationBarTheme:
            BottomNavigationBarThemeData(type: BottomNavigationBarType.fixed));
  }

  static final TextTheme _textTheme = TextTheme(
      headlineLarge: TextStyle(
        fontSize: 25.sp,
        fontWeight: FontWeight.w600,
        color: authenticationHeaderColor,
      ),
      titleLarge: TextStyle(
        fontSize: 19.8.sp,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(fontSize: 16.8.sp, fontWeight: FontWeight.normal),
      labelLarge: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
      labelSmall: TextStyle(
          fontSize: 15.sp, fontWeight: FontWeight.w400, color: lightGrey));
}
