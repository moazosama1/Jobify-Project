import 'package:flutter/material.dart';
import 'package:jobify_project/core/constants/app_icons.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/widgets/custom_app_bar.dart';
import 'package:jobify_project/core/widgets/custom_search_bar.dart';
import 'package:jobify_project/core/widgets/job_card.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';

class SavedJobsViewBody extends StatelessWidget {
  const SavedJobsViewBody({super.key});

 final JobEntity jobEntity = const JobEntity(
    id: "1",
    companyName: "Google",
    logoAsset: AppIcons.appleIcon,
    title: "fluuter",
    salary: "15000",
    tags: ["Egypt"],
    location: "Cairo",
    isBookmarked: true,
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        const CustomAppBar(title: "Saved jobs"),
        const SizedBox(height: AppMeasurements.paddingLarge),
        const CustomSearchBar(hintText: "search"),
        const SizedBox(height: AppMeasurements.paddingLarge),
        Text(
          "189 Saved jobs",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: AppMeasurements.paddingSmall),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppMeasurements.paddingMedium,
                ),
                child: JobCard(onTap: () {}, job: jobEntity),
              );
            },
          ),
        ),
      ],
    );
  }
}
