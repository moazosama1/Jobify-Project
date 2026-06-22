import 'package:flutter/material.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import 'package:jobify_project/presentation/job_seeker/job_details/view/widgets/job_details_screen_view_body.dart';

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScreenWrapper(body: JobDetailsScreenViewBody()),
    );
  }
}
