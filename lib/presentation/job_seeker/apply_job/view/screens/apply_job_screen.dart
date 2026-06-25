import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import 'package:jobify_project/core/di/di.dart';
import 'package:jobify_project/presentation/job_seeker/apply_job/view_model/apply_job_cubit.dart';
import 'package:jobify_project/presentation/job_seeker/apply_job/view/widgets/apply_job_view_body.dart';

class ApplyJobScreen extends StatelessWidget {
  final String jobId;

  const ApplyJobScreen({super.key, required this.jobId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ApplyJobCubit>(),
      child: CustomScreenWrapper(body: ApplyJobViewBody(jobId: jobId)),
    );
  }
}
