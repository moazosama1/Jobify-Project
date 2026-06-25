import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';
import 'package:jobify_project/core/widgets/custom_app_bar.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import 'package:jobify_project/core/widgets/custom_toastification.dart';
import 'package:jobify_project/presentation/job_seeker/job_details/view/widgets/job_details_screen_view_body.dart';
import 'package:jobify_project/presentation/job_seeker/job_details/view_model/job_details_cubit.dart';
import 'package:jobify_project/presentation/job_seeker/job_details/view_model/job_details_state.dart';
import 'package:toastification/toastification.dart';

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<JobDetailsCubit, JobDetailsState>(
        listenWhen: (previous, current) =>
            previous.actionMessage != current.actionMessage,
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
        child: CustomScreenWrapper(
          appBar: CustomAppBar(
            title: context.l10n.details,
          ),
          body: const JobDetailsScreenViewBody(),
        ),
      ),
    );
  }
}
