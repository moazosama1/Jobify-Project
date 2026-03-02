import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jobify_project/core/constants/app_theme.dart';
import 'package:jobify_project/core/constants/const_keys.dart';
import 'package:jobify_project/core/cubit/core_cubit.dart';
import 'package:jobify_project/core/di/di.dart';
import 'package:jobify_project/core/responsive/app_responsive.dart';
import 'package:jobify_project/core/router/app_router.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:jobify_project/my_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  Bloc.observer = MyBlocObserver();
  runApp(
    BlocProvider(
      create: (context) => getIt<CoreCubit>(),
      child: const AppResponsive(width: 390, child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoreCubit, CoreState>(
      builder: (context, state) {
        ThemeMode currentThemeMode = ThemeMode.light;
        Locale currentLocale = const Locale(ConstKeys.kEnglish);

        if (state is CoreStateChanged) {
          currentThemeMode = state.themeMode;
          currentLocale = state.locale;
        }
        return MaterialApp.router(
          title: AppLocalizations().appName,
          debugShowCheckedModeBanner: false,
          themeMode: currentThemeMode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          routerConfig: AppRouter.router,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.delegate.supportedLocales,
          locale: currentLocale,
        );
      },
    );
  }
}
