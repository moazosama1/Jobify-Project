import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/di/di.dart';
import 'package:jobify_project/core/router/route_names.dart';
import 'package:jobify_project/presentation/onboarding/view_model/onboarding_cubit.dart';
import 'package:jobify_project/presentation/onboarding/view/screens/onboarding_screen.dart';
import 'package:jobify_project/presentation/splash/view_model/splash_cubit.dart';
import 'package:jobify_project/presentation/splash/view/screens/splash_screen.dart';
import 'package:jobify_project/presentation/auth/login/view/screens/login_screen.dart';
import 'package:jobify_project/presentation/auth/login/view_model/login_cubit.dart';

abstract class AppRouter {
  static final router = GoRouter(
    initialLocation: RouteNames.splash,
    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<SplashCubit>(),
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: RouteNames.onboarding,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<OnboardingCubit>(),
          child: const OnboardingScreen(),
        ),
      ),
      GoRoute(
        path: RouteNames.home,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text("Home"))),
      ),
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<LoginCubit>(),
          child: const LoginScreen(),
        ),
      ),
    ],
  );
}
