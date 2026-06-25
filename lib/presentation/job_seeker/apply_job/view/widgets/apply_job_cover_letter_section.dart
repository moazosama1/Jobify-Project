import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';
import 'package:jobify_project/core/widgets/custom_text_field.dart';
import 'package:jobify_project/presentation/job_seeker/apply_job/view_model/apply_job_cubit.dart';
import 'package:jobify_project/presentation/job_seeker/apply_job/view_model/apply_job_events.dart';

class ApplyJobCoverLetterSection extends StatelessWidget {
  const ApplyJobCoverLetterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.motivationalLetter,
          style: context.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppMeasurements.paddingMedium),
        CustomTextField(
          hintText: context.l10n.writeSomething,
          maxLines: 5,
          validator: (value) {
            if (value == null || value.trim().length < 20) {
              return "Cover letter must be at least 20 characters";
            }
            return null;
          },
          onChanged: (value) {
            context.read<ApplyJobCubit>().doIntent(InputCoverLetterApplyJobEvent(value));
          },
        ),
      ],
    );
  }
}
