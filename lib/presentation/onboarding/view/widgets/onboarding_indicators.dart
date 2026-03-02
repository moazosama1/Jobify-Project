import 'package:flutter/material.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';

class OnboardingIndicators extends StatelessWidget {
  final int totalPages;
  final int currentIndex;

  const OnboardingIndicators({
    super.key,
    required this.totalPages,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(
            horizontal: AppMeasurements.paddingExtraSmall,
          ),
          height: AppMeasurements.paddingSmall,
          width: currentIndex == index
              ? AppMeasurements.paddingExtraLarge
              : AppMeasurements.paddingMedium,
          decoration: BoxDecoration(
            color: currentIndex == index
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(
              AppMeasurements.paddingExtraSmall,
            ),
          ),
        ),
      ),
    );
  }
}
