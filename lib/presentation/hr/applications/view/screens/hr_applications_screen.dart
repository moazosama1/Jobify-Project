import 'package:flutter/material.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import 'widgets/hr_applications_view_body.dart';

class HrApplicationsScreen extends StatelessWidget {
  const HrApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScreenWrapper(
        // applyPadding: false,
        body: HrApplicationsViewBody(),
      ),
    );
  }
}
