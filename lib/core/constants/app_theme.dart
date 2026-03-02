import 'package:flutter/material.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/constants/const_keys.dart';

abstract class AppTheme {
  static ThemeData get lightTheme => _buildTheme(
    colorScheme: colorSchemeLight,
    scaffoldBackgroundColor: AppColors.white,
    surfaceColor: AppColors.white,
    primaryTextColor: AppColors.black,
    shadowColor: AppColors.black.withValues(alpha: 0.05),
    bottomNavElevation: 8,
  );

  static ThemeData get darkTheme => _buildTheme(
    colorScheme: colorSchemeDark,
    scaffoldBackgroundColor: AppColors.black,
    surfaceColor: AppColors.black[50]!,
    primaryTextColor: AppColors.white,
    shadowColor: AppColors.black.withValues(alpha: 0.2),
    bottomNavElevation: 0,
  );

  static ThemeData _buildTheme({
    required ColorScheme colorScheme,
    required Color scaffoldBackgroundColor,
    required Color surfaceColor,
    required Color primaryTextColor,
    required Color shadowColor,
    required double bottomNavElevation,
  }) {
    final secondaryTextColor = colorScheme.secondary;

    return ThemeData(
      useMaterial3: true,
      fontFamily: ConstKeys.cairoFont,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      colorScheme: colorScheme,

      // Typography
      textTheme: TextTheme(
        bodySmall: getTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: secondaryTextColor,
        ),
        bodyMedium: getTextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: secondaryTextColor,
        ),
        bodyLarge: getTextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: secondaryTextColor,
        ),

        headlineSmall: getTextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: secondaryTextColor,
        ),
        headlineMedium: getTextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: secondaryTextColor,
        ),
        headlineLarge: getTextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          color: secondaryTextColor,
        ),

        labelSmall: getTextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: secondaryTextColor,
        ),
        labelMedium: getTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: secondaryTextColor,
        ),
        labelLarge: getTextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: secondaryTextColor,
        ),
      ),

      // App Bar
      appBarTheme: AppBarTheme(
        backgroundColor: scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: primaryTextColor),
        titleTextStyle: getTextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: primaryTextColor,
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // Input Fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: getTextStyle(color: AppColors.gray, fontSize: 14),
        labelStyle: getTextStyle(color: primaryTextColor, fontSize: 14),
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
        backgroundColor: surfaceColor,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        titleTextStyle: getTextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: primaryTextColor,
        ),
        contentTextStyle: getTextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: primaryTextColor,
        ),
      ),

      // Bottom Sheet
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surfaceColor,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),

      // Cards
      cardTheme: CardThemeData(
        color: surfaceColor,
        surfaceTintColor: Colors.transparent,
        elevation: 2,
        shadowColor: shadowColor,
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
        backgroundColor: scaffoldBackgroundColor,
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
        elevation: bottomNavElevation,
      ),
    );
  }

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

ColorScheme colorSchemeLight = ColorScheme(
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
);

ColorScheme colorSchemeDark = ColorScheme(
  brightness: Brightness.dark,
  primary: AppColors.mainColor,
  onPrimary: AppColors.white,
  secondary: AppColors.white,
  onSecondary: AppColors.black,
  tertiary: AppColors.splashBackground,
  error: AppColors.red,
  onError: AppColors.white,
  surface: AppColors.black,
  onSurface: AppColors.white,
);
