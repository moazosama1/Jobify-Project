part of 'core_cubit.dart';

@immutable
sealed class CoreState {}

final class CoreInitial extends CoreState {}

final class CoreStateChanged extends CoreState {
  final ThemeMode themeMode;
  final Locale locale;
  final UserEntity? user;

  CoreStateChanged({
    required this.themeMode,
    required this.locale,
    this.user,
  });

  CoreStateChanged copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    UserEntity? user,
  }) {
    return CoreStateChanged(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      user: user ?? this.user,
    );
  }
}
