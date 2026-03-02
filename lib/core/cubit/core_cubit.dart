import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jobify_project/core/constants/const_keys.dart';

part 'core_state.dart';

@singleton
class CoreCubit extends Cubit<CoreState> {
  final SharedPreferences _prefs;

  CoreCubit(this._prefs) : super(CoreInitial()) {
    _loadSettings();
  }

  static CoreCubit get(BuildContext context) => BlocProvider.of(context);

  void _loadSettings() {
    final isDark = _prefs.getBool(ConstKeys.kAppThemeDark) ?? false;
    final localeCode =
        _prefs.getString(ConstKeys.kAppLocale) ?? ConstKeys.kEnglish;

    emit(
      CoreStateChanged(
        themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
        locale: Locale(localeCode),
      ),
    );
  }

  void toggleTheme() {
    if (state is CoreStateChanged) {
      final currentState = state as CoreStateChanged;
      final isCurrentlyDark = currentState.themeMode == ThemeMode.dark;

      _prefs.setBool(ConstKeys.kAppThemeDark, !isCurrentlyDark);

      emit(
        currentState.copyWith(
          themeMode: !isCurrentlyDark ? ThemeMode.dark : ThemeMode.light,
        ),
      );
    }
  }

  void changeLocale(String languageCode) {
    if (state is CoreStateChanged) {
      final currentState = state as CoreStateChanged;

      _prefs.setString(ConstKeys.kAppLocale, languageCode);

      emit(currentState.copyWith(locale: Locale(languageCode)));
    }
  }
}
