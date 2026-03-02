import 'package:flutter/material.dart';
import 'package:jobify_project/core/widgets/custom_loading_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/constants/const_keys.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/router/route_names.dart';
import 'package:jobify_project/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:jobify_project/features/splash/presentation/view_model/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashNavigateToOnboarding) {
          context.go(RouteNames.onboarding);
        } else if (state is SplashNavigateToHome) {
          context.go(RouteNames.home);
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                ConstKeys.appName,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onTertiary,
                ),
              ),
              const Spacer(),
              CustomLoadingIndicator(
                color: Theme.of(context).colorScheme.onTertiary,
              ),
              const SizedBox(height: AppMeasurements.buttonHeight),
            ],
          ),
        ),
      ),
    );
  }
}
