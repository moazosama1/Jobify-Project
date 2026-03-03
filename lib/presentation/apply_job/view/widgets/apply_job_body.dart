import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/widgets/custom_toastification.dart';
import 'package:jobify_project/presentation/apply_job/view_model/apply_job_cubit.dart';
import 'package:jobify_project/presentation/apply_job/view_model/apply_job_state.dart';
import 'package:jobify_project/presentation/apply_job/view/widgets/apply_job_form_view.dart';
import 'package:jobify_project/presentation/apply_job/view/widgets/apply_job_success_view.dart';
import 'package:toastification/toastification.dart';

class ApplyJobBody extends StatelessWidget {
  const ApplyJobBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ApplyJobCubit, ApplyJobState>(
      listenWhen: (previous, current) =>
          previous.apiStatus != current.apiStatus,
      listener: (context, state) {
        if (state.apiStatus.errorMessage != null) {
          customToastification(
            context,
            ToastificationType.error,
            state.apiStatus.errorMessage,
          );
        }
      },
      child: BlocBuilder<ApplyJobCubit, ApplyJobState>(
        builder: (context, state) {
          if (state.apiStatus.data == true) {
            return const ApplyJobSuccessView();
          }
          return const ApplyJobFormView();
        },
      ),
    );
  }
}
