import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import 'package:jobify_project/core/widgets/custom_toastification.dart';
import 'package:jobify_project/presentation/job_seeker/saved_jobs/view/widgets/saved_jobs_view_body.dart';
import 'package:jobify_project/presentation/job_seeker/saved_jobs/view_model/saved_jobs_cubit.dart';
import 'package:jobify_project/presentation/job_seeker/saved_jobs/view_model/saved_jobs_state.dart';
import 'package:toastification/toastification.dart';

class SavedJobsScreen extends StatelessWidget {
  const SavedJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SavedJobsCubit, SavedJobsState>(
      listenWhen: (previous, current) =>
          previous.actionMessage != current.actionMessage &&
          current.actionMessage != null,
      listener: (context, state) {
        if (state.actionMessage != null) {
          customToastification(
            context,
            state.isActionSuccess
                ? ToastificationType.success
                : ToastificationType.error,
            state.actionMessage,
          );
        }
      },
      child: const Scaffold(
        body: CustomScreenWrapper(body: SavedJobsViewBody()),
      ),
    );
  }
}

