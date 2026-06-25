import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';
import 'package:jobify_project/presentation/job_seeker/apply_job/view_model/apply_job_cubit.dart';
import 'package:jobify_project/presentation/job_seeker/apply_job/view_model/apply_job_events.dart';
import 'package:jobify_project/presentation/job_seeker/apply_job/view_model/apply_job_state.dart';

class ApplyJobUploadResumeSection extends StatelessWidget {
  const ApplyJobUploadResumeSection({super.key});

  Future<void> _pickResume(BuildContext context) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg'],
    );

    if (result != null && result.files.single.path != null) {
      if (context.mounted) {
        context.read<ApplyJobCubit>().doIntent(SelectResumeApplyJobEvent(result.files.single.path!));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.uploadCv,
          style: context.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppMeasurements.paddingMedium),
        GestureDetector(
          onTap: () => _pickResume(context),
          child: DottedBorder(
            options: RoundedRectDottedBorderOptions(
              color: context.primaryColor,
              strokeWidth: 2,
              dashPattern: const [6, 4],
              radius: const Radius.circular(AppMeasurements.radiusMedium),
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: context.primaryColor.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(AppMeasurements.radiusMedium),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cloud_upload_outlined,
                    size: 48,
                    color: context.primaryColor,
                  ),
                  const SizedBox(height: AppMeasurements.paddingMedium),
                  Text(
                    context.l10n.browseFiles,
                    style: context.bodyMedium?.copyWith(
                      color: context.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    context.l10n.formatDocPdfJpg,
                    style: context.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                  const SizedBox(height: AppMeasurements.paddingMedium),
                  BlocBuilder<ApplyJobCubit, ApplyJobState>(
                    buildWhen: (previous, current) => previous.resumeFilePath != current.resumeFilePath,
                    builder: (context, state) {
                      if (state.resumeFilePath != null && state.resumeFilePath!.isNotEmpty) {
                        final fileName = state.resumeFilePath!.split('/').last;
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: context.primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(AppMeasurements.radiusMedium),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.description, size: 16, color: context.primaryColor),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  fileName,
                                  style: context.bodySmall?.copyWith(color: context.primaryColor),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
