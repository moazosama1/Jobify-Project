import 'package:flutter/material.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import '../widgets/hr_job_applications_view_body.dart';

class HrJobApplicationsScreen extends StatelessWidget {
  final String jobTitle;

  const HrJobApplicationsScreen({
    super.key,
    required this.jobTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScreenWrapper(
        body: HrJobApplicationsViewBody(jobTitle: jobTitle),
      ),
    );
  }
}
