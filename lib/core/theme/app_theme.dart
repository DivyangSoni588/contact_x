import 'package:contact_x/core/resources/app_colors.dart';
import 'package:contact_x/core/resources/app_text_style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData appTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.cyan,
    scaffoldBackgroundColor: AppColors.whiteColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.cyanColor,
      foregroundColor: AppColors.whiteColor,
    ),
    useMaterial3: true,
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: AppTextStyle.regularFont,
      inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.whiteColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.cyan,
        // Button background color
        foregroundColor: Colors.white,
        // Text color
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
