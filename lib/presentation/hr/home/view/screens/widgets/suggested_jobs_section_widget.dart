import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:jobify_project/core/widgets/suggested_job_card.dart';
import 'package:jobify_project/presentation/job_seeker/home/view_model/home_cubit.dart';
import 'package:jobify_project/presentation/job_seeker/home/view_model/home_event.dart';

class SuggestedJobsSectionWidget extends StatelessWidget {
  final List<JobEntity> suggestedJobs;
  final AppLocalizations local;
  final VoidCallback onSeeAllPressed;

  const SuggestedJobsSectionWidget({
    super.key,
    required this.suggestedJobs,
    required this.local,
    required this.onSeeAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (suggestedJobs.isEmpty) {
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
                local.suggestedJobs,
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
        SizedBox(
          height: 180,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: AppMeasurements.paddingLarge,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: suggestedJobs.length,
            separatorBuilder: (context, index) =>
                const SizedBox(width: AppMeasurements.paddingMedium),
            itemBuilder: (context, index) {
              final job = suggestedJobs[index];
              return SuggestedJobCard(
                job: job,
                onBookmarkTap: () {
                  context.read<HomeCubit>().doIntent(
                    HomeToggleBookmarkEvent(job.id),
                  );
                },
                onApplyTap: () {
                  // Navigate to apply job details or form.
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
