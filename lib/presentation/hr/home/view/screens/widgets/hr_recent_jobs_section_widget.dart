import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/router/route_names.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:jobify_project/core/widgets/job_card.dart';
import 'package:jobify_project/presentation/hr/home/view_model/hr_home_cubit.dart';
import 'package:jobify_project/presentation/hr/home/view_model/hr_home_event.dart';

import 'package:jobify_project/core/extensions/theme_context_extension.dart';

class HrRecentJobsSectionWidget extends StatelessWidget {
  final List<JobEntity> recentJobs;
  final AppLocalizations local;
  final VoidCallback onSeeAllPressed;

  const HrRecentJobsSectionWidget({
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
                local.postedJobs,
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
              onTap: () {
                context.push(
                  RouteNames.hrJobApplications,
                  extra: {'jobId': job.id, 'jobTitle': job.title},
                );
              },
              job: job,
              onEditTap: () async {
                await context.push(
                  RouteNames.hrHiringPost,
                  extra: job,
                );
                if (context.mounted) {
                  context.read<HrHomeCubit>().doIntent(LoadHrHomeEvent());
                }
              },
              onDeleteTap: () {
                showDialog(
                  context: context,
                  builder: (dialogContext) {
                    return AlertDialog(
                      title: Text(local.deleteConfirmTitle),
                      content: Text(local.deleteConfirmMessage),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          child: Text(local.no),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(dialogContext);
                            context.read<HrHomeCubit>().doIntent(
                                  DeleteJobHrHomeEvent(job.id),
                                );
                          },
                          child: Text(
                            local.delete,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}
