import 'package:flutter/material.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/constants/const_keys.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: ConstKeys.interFont,
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.mainColor,
      onPrimary: AppColors.white,
      secondary: AppColors.black,
      onSecondary: AppColors.white,
      tertiary: AppColors.splashBackground,
      error: AppColors.red,
      onError: AppColors.white,
      surface: AppColors.white,
      onSurface: AppColors.black,
    ),

    // Typography
    textTheme: TextTheme(
      bodySmall: getTextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.gray,
      ),
      bodyMedium: getTextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      ),
      bodyLarge: getTextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),

      headlineSmall: getTextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
      headlineMedium: getTextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      ),
      headlineLarge: getTextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      ),

      labelSmall: getTextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.gray,
      ),
      labelMedium: getTextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.mainColor,
      ),
      labelLarge: getTextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
    ),

    // App Bar
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.black),
      titleTextStyle: getTextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
    ),

    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.mainColor,
        foregroundColor: AppColors.white,
        disabledBackgroundColor: AppColors.gray.withValues(alpha: 0.3),
        elevation: 0,
        textStyle: getTextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.mainColor,
        textStyle: getTextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.mainColor,
        side: BorderSide(color: AppColors.mainColor),
        textStyle: getTextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    // Input Fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      hintStyle: getTextStyle(color: AppColors.gray, fontSize: 14),
      labelStyle: getTextStyle(color: AppColors.black, fontSize: 14),
      floatingLabelStyle: getTextStyle(
        color: AppColors.mainColor,
        fontSize: 12,
      ),
      errorStyle: getTextStyle(color: AppColors.red, fontSize: 12),

      border: getOutlineInputBorder(
        color: AppColors.gray.withValues(alpha: 0.3),
      ),
      enabledBorder: getOutlineInputBorder(
        color: AppColors.gray.withValues(alpha: 0.3),
      ),
      focusedBorder: getOutlineInputBorder(
        color: AppColors.mainColor,
        width: 1.5,
      ),
      errorBorder: getOutlineInputBorder(color: AppColors.red),
      focusedErrorBorder: getOutlineInputBorder(
        color: AppColors.red,
        width: 1.5,
      ),
    ),

    // Dialogs
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titleTextStyle: getTextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
      contentTextStyle: getTextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      ),
    ),

    // Bottom Sheet
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.white,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    ),

    // Cards
    cardTheme: CardThemeData(
      color: AppColors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.zero,
    ),

    // Dividers
    dividerTheme: DividerThemeData(
      color: AppColors.gray.withValues(alpha: 0.2),
      thickness: 1,
      space: 1,
    ),

    // Bottom Navigation Bar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.mainColor,
      unselectedItemColor: AppColors.gray,
      selectedLabelStyle: getTextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.mainColor,
      ),
      unselectedLabelStyle: getTextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.gray,
      ),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
  );

  static OutlineInputBorder getOutlineInputBorder({
    required Color color,
    double width = 1.0,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  static TextStyle getTextStyle({
    Color? color,
    double? fontSize,
    String? fontFamily,
    FontWeight? fontWeight,
    double? height,
  }) {
    return TextStyle(
      color: color ?? AppColors.black,
      fontSize: fontSize ?? 14,
      fontFamily: fontFamily ?? ConstKeys.interFont,
      fontWeight: fontWeight ?? FontWeight.w400,
      height: height,
    );
  }
}
