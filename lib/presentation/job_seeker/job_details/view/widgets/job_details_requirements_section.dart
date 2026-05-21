import 'package:flutter/material.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';

class JobDetailsRequirementsSection extends StatelessWidget {
  final String description;
  final List<String> requirements;
  final VoidCallback onApplyPressed;

  const JobDetailsRequirementsSection({
    super.key,
    required this.description,
    required this.requirements,
    required this.onApplyPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About The Role',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppMeasurements.paddingSmall),
        Text(
          description,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
            height: 1.5,
          ),
        ),
        const SizedBox(height: AppMeasurements.paddingLarge),
        Text(
          'Requirement Skill For The Role',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppMeasurements.paddingSmall),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: requirements.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppMeasurements.paddingExtraSmall,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(top: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: AppMeasurements.paddingSmall),
                  Expanded(
                    child: Text(item, style: theme.textTheme.bodyMedium),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: AppMeasurements.paddingLarge),
        SizedBox(
          width: double.infinity,
          height: AppMeasurements.buttonHeight,
          child: ElevatedButton(
            onPressed: onApplyPressed,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text('Apply This Job'),
          ),
        ),
      ],
    );
  }
}
