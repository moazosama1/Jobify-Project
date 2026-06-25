import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';
import 'package:jobify_project/core/widgets/custom_app_bar.dart';
import 'package:jobify_project/core/widgets/custom_elevated_button_loading.dart';
import 'package:jobify_project/core/widgets/custom_toastification.dart';
import 'package:toastification/toastification.dart';
import 'package:jobify_project/presentation/job_seeker/apply_job/view_model/apply_job_cubit.dart';
import 'package:jobify_project/presentation/job_seeker/apply_job/view_model/apply_job_events.dart';
import 'package:jobify_project/presentation/job_seeker/apply_job/view_model/apply_job_state.dart';
import 'package:jobify_project/presentation/job_seeker/apply_job/view/widgets/apply_job_cover_letter_section.dart';
import 'package:jobify_project/presentation/job_seeker/apply_job/view/widgets/apply_job_upload_resume_section.dart';

class ApplyJobViewBody extends StatefulWidget {
  final String jobId;

  const ApplyJobViewBody({super.key, required this.jobId});

  @override
  State<ApplyJobViewBody> createState() => _ApplyJobViewBodyState();
}

class _ApplyJobViewBodyState extends State<ApplyJobViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ApplyJobCubit, ApplyJobState>(
      listenWhen: (previous, current) =>
          previous.applyStatus != current.applyStatus,
      listener: (context, state) {
        if (state.applyStatus.errorMessage != null) {
          final error = state.applyStatus.errorMessage!;
          customToastification(context, ToastificationType.error, error);
        } else if (state.applyStatus.data != null) {
          customToastification(
            context,
            ToastificationType.success,
            context.l10n.youHaveSuccessfullyApplied,
          );
          context.pop(); // Go back after success
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: context.l10n.applyJob,
          showBackButton: true,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppMeasurements.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ApplyJobUploadResumeSection(),
                const SizedBox(height: AppMeasurements.paddingSmall),
                const ApplyJobCoverLetterSection(),
                const SizedBox(height: AppMeasurements.paddingMedium * 2),
                BlocBuilder<ApplyJobCubit, ApplyJobState>(
                  builder: (context, state) {
                    return CustomElevatedButtonLoading(
                      widthButton: 200,
                      isLoading: state.applyStatus.isLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<ApplyJobCubit>().doIntent(
                            SubmitApplyJobEvent(widget.jobId),
                          );
                        }
                      },
                      textButton: context.l10n.applyThisJob,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
