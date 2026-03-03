import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/widgets/custom_elevated_button_loading.dart';
import 'package:jobify_project/presentation/onboarding/view_model/onboarding_cubit.dart';
import 'package:jobify_project/presentation/onboarding/view_model/onboarding_event.dart';
import 'package:jobify_project/generated/l10n.dart';

class OnboardingButtons extends StatelessWidget {
  final int totalPages;
  final bool isLastPage;

  const OnboardingButtons({
    super.key,
    required this.totalPages,
    required this.isLastPage,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppMeasurements.paddingLarge,
      ),
      child: Column(
        children: [
          CustomElevatedButtonLoading(
            heightButton: AppMeasurements.buttonHeight,
            widthButton: double.infinity,
            textButton: isLastPage ? local.getStarted : local.next,
            borderButton: AppMeasurements.paddingMedium,
            textStyleButton: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
            onPressed: () {
              context.read<OnboardingCubit>().onNextClicked(
                OnboardingNextClickedEvent(),
                totalPages,
              );
            },
          ),
          const SizedBox(height: AppMeasurements.paddingMedium),
          if (!isLastPage)
            CustomElevatedButtonLoading(
              heightButton: AppMeasurements.buttonHeight,
              widthButton: double.infinity,
              textButton: local.skip,
              borderButton: AppMeasurements.paddingMedium,
              textStyleButton: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
              ),
              colorButton: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.1),
              elevation: 0,
              onPressed: () {
                context.read<OnboardingCubit>().onSkipClicked(
                  OnboardingSkipClickedEvent(),
                );
              },
            )
          else
            const SizedBox(height: AppMeasurements.buttonHeight),
        ],
      ),
    );
  }
}
