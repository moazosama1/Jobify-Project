import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/router/route_names.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:jobify_project/core/widgets/job_card.dart';
import 'package:jobify_project/presentation/job_seeker/home/view_model/home_cubit.dart';
import 'package:jobify_project/presentation/job_seeker/home/view_model/home_event.dart';

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
                style: context.titleMedium?.copyWith(
                  color: context.onSurfaceColor,
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
                context.read<HomeCubit>().doIntent(
                  HomeToggleBookmarkEvent(job.id),
                );
              },
              onApplyTap: () {
                context.push(RouteNames.applyJob, extra: job.id);
              },
            );
          },
        ),
      ],
    );
  }
}
