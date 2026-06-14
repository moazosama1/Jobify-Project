import 'package:flutter/material.dart';
import 'package:jobify_project/core/constants/app_images.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/widgets/custom_app_bar.dart';
import 'package:jobify_project/core/widgets/custom_application_card.dart';
import 'package:jobify_project/core/widgets/custom_search_bar.dart';
import 'package:jobify_project/generated/l10n.dart';

class HrApplicationsViewBody extends StatelessWidget {
  const HrApplicationsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return Column(
      children: [
        CustomAppBar(title: local.incomingApplications, showBackButton: false),
        const CustomSearchBar(hintText: " Search ..."),
        const SizedBox(height: AppMeasurements.paddingMedium),

        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return SizedBox(
                width: double.infinity,
                child: CustomJobApplicationCard(
                  jobTitle: 'Product Designer',
                  companyName: 'Google LLC',
                  salary: '\$6k',
                  location: 'United States',
                  logoUrl: AppImages.iconFacebook,
                  status: ApplicationStatus.onTheWay,
                  onViewApplication: () {},
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
