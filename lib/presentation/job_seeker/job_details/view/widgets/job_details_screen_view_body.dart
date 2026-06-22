import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/router/route_names.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:jobify_project/core/widgets/suggested_job_card.dart';
import 'package:jobify_project/presentation/job_seeker/job_details/view/widgets/job_details_header_section.dart';
import 'package:jobify_project/presentation/job_seeker/job_details/view/widgets/job_details_requirements_section.dart';

class JobDetailsScreenViewBody extends StatelessWidget {
  const JobDetailsScreenViewBody({super.key});

  static const _description =
      'We are looking for a senior UX Designer. They say no man is an island, and this holds particularly true of this role. As a UX Designer, you’ll be part of the team that manages Go Pay Southeast Asia’s largest payment application.';

  static final _requirements = [
    'Create information architecture and UX strategy',
    'Develop UI mockups and prototypes that clearly illustrate how sites function and look like',
    'Fluent English communication skills are a must.',
    'Have a good communication skill',
  ];

  static final _job = const JobEntity(
    id: 'd1',
    companyName: 'Google LLC',
    logoAsset: 'assets/icons/google.png',
    title: 'Senior UX Designer',
    salary: '\$195,000',
    tags: ['Design', 'Full Time', 'In House'],
    location: 'Berlin Germany',
    isBookmarked: true,
  );

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppMeasurements.paddingSmall),
          JobDetailsHeaderSection(
            title: 'Details',
            onSkipPressed: () {
              context.pop();
            },
          ),
          const SizedBox(height: AppMeasurements.paddingLarge),
          Center(
            child: SuggestedJobCard(job: _job, width: double.infinity),
          ),

          const SizedBox(height: AppMeasurements.paddingLarge),
          JobDetailsRequirementsSection(
            description: _description,
            requirements: _requirements,
            onApplyPressed: () {
              context.push(RouteNames.applyJob);
            },
          ),
        ],
      ),
    );
  }
}
