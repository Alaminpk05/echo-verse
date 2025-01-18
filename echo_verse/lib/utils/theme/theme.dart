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
      colorScheme: ColorScheme.fromSeed(seedColor: teal,
      primary: teal),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36.sp)),
        backgroundColor: teal,
        
        
      )
    )
    
    
    
    
    );
    





  }

  static final TextTheme _textTheme = TextTheme(
    
    
      headlineLarge: TextStyle(
          fontSize: 25.sp,
          fontWeight: FontWeight.w600,
          color: authenticationHeaderColor,),
      labelLarge: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: authenticationHeaderColor),
      labelMedium: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: authenticationHeaderColor),
      labelSmall: TextStyle(
          fontSize: 15.sp, fontWeight: FontWeight.w400, color: lightGrey));
}
