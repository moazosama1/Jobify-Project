part of 'core_cubit.dart';

@immutable
sealed class CoreState {}

final class CoreInitial extends CoreState {}

final class CoreStateChanged extends CoreState {
  final ThemeMode themeMode;
  final Locale locale;

  CoreStateChanged({required this.themeMode, required this.locale});

  CoreStateChanged copyWith({ThemeMode? themeMode, Locale? locale}) {
    return CoreStateChanged(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
    );
  }
}
