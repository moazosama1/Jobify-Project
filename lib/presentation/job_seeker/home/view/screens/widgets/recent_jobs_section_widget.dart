import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/router/route_names.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:jobify_project/core/widgets/job_card.dart';

class RecentJobsSectionWidget extends StatelessWidget {
  final List<JobEntity> recentJobs;
  final AppLocalizations local;
  final VoidCallback onSeeAllPressed;

  const RecentJobsSectionWidget({
    super.key,
    required this.recentJobs,
    required this.local,
    required this.onSeeAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (recentJobs.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppMeasurements.paddingLarge,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                local.recentJobs,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              TextButton(onPressed: onSeeAllPressed, child: Text(local.seeAll)),
            ],
          ),
        ),
        const SizedBox(height: AppMeasurements.paddingSmall),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: AppMeasurements.paddingMedium,
          ),
          itemCount: recentJobs.length,
          separatorBuilder: (context, index) =>
              const SizedBox(height: AppMeasurements.paddingMedium),
          itemBuilder: (context, index) {
            final job = recentJobs[index];
            return JobCard(
              onTap: () => context.push(RouteNames.jobDetails, extra: job),
              job: job,
              onOptionsTap: () {
                // Show options modal sheet.
              },
            );
          },
        ),
      ],
    );
  }
}
