import 'package:flutter/material.dart';
import 'package:jobify_project/core/constants/app_images.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/widgets/custom_search_bar.dart';

class HrSearchSectionWidget extends StatelessWidget {
  final String hintText;
  final VoidCallback onFilterPressed;

  const HrSearchSectionWidget({
    super.key,
    required this.hintText,
    required this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppMeasurements.paddingLarge,
          ),
          child: CustomSearchBar(
            hintText: hintText,
            onChanged: (_) {
              // Keep the search field UI-only.
            },
            onFilterPressed: onFilterPressed,
          ),
        ),
        const SizedBox(height: AppMeasurements.paddingLarge),
        Center(child: Image.asset(AppImages.letsFindNewJob)),
      ],
    );
  }
}
