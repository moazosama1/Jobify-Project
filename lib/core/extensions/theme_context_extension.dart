import 'package:flutter/material.dart';

extension ThemeContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;

  // Colors
  Color get primaryColor => colorScheme.primary;
  Color get onPrimaryColor => colorScheme.onPrimary;
  Color get secondaryColor => colorScheme.secondary;
  Color get onSecondaryColor => colorScheme.onSecondary;
  Color get surfaceColor => colorScheme.surface;
  Color get onSurfaceColor => colorScheme.onSurface;
  Color get errorColor => colorScheme.error;

  // Text Styles
  TextStyle? get bodySmall => textTheme.bodySmall;
  TextStyle? get bodyMedium => textTheme.bodyMedium;
  TextStyle? get bodyLarge => textTheme.bodyLarge;
  TextStyle? get headlineSmall => textTheme.headlineSmall;
  TextStyle? get headlineMedium => textTheme.headlineMedium;
  TextStyle? get headlineLarge => textTheme.headlineLarge;
  TextStyle? get labelSmall => textTheme.labelSmall;
  TextStyle? get labelMedium => textTheme.labelMedium;
  TextStyle? get labelLarge => textTheme.labelLarge;
  TextStyle? get titleSmall => textTheme.titleSmall;
  TextStyle? get titleMedium => textTheme.titleMedium;
  TextStyle? get titleLarge => textTheme.titleLarge;
}
