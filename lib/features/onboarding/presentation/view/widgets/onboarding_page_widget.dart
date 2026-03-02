import 'package:flutter/material.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';

class OnboardingPageWidget extends StatelessWidget {
  final String title;
  final String description;
  final Widget? imagePlaceholder;

  const OnboardingPageWidget({
    super.key,
    required this.title,
    required this.description,
    this.imagePlaceholder,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppMeasurements.paddingLarge,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: Center(
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: theme.colorScheme.primary,
                    width: 16,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Center(
                    child:
                        imagePlaceholder ??
                        Icon(
                          Icons.work_outline,
                          size: 100,
                          color: theme.colorScheme.primary,
                        ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppMeasurements.paddingMedium),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
