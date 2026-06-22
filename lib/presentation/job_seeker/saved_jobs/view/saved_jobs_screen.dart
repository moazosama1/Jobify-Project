import 'package:flutter/material.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import 'package:jobify_project/presentation/job_seeker/saved_jobs/view/widgets/saved_jobs_view_body.dart';

class SavedJobsScreen extends StatelessWidget {
  const SavedJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScreenWrapper(body:SavedJobsViewBody() ),
    );
  }
}