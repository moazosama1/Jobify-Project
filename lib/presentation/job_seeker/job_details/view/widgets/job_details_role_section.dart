import 'package:flutter/material.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';

class JobDetailsRoleSection extends StatelessWidget {
  final JobEntity job;

  const JobDetailsRoleSection({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppMeasurements.paddingLarge),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7B61FF), Color(0xFF623ECA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(AppMeasurements.paddingSmall),
                child: Image.asset(job.logoAsset, fit: BoxFit.contain),
              ),
              const SizedBox(width: AppMeasurements.paddingLarge),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.title,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppMeasurements.paddingSmall),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Colors.white70,
                          size: 16,
                        ),
                        const SizedBox(
                          width: AppMeasurements.paddingExtraSmall,
                        ),
                        Flexible(
                          child: Text(
                            job.location,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppMeasurements.paddingLarge),
          Wrap(
            spacing: AppMeasurements.paddingSmall,
            runSpacing: AppMeasurements.paddingSmall,
            children: job.tags.map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppMeasurements.paddingSmall + 4,
                  vertical: AppMeasurements.paddingExtraSmall + 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  tag,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
