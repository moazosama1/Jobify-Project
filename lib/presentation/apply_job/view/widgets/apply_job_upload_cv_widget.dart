import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:jobify_project/presentation/apply_job/view_model/apply_job_cubit.dart';
import 'package:jobify_project/presentation/apply_job/view_model/apply_job_event.dart';
import 'package:jobify_project/presentation/apply_job/view_model/apply_job_state.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/constants/app_colors.dart';

class ApplyJobUploadCvWidget extends StatelessWidget {
  const ApplyJobUploadCvWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return BlocBuilder<ApplyJobCubit, ApplyJobState>(
      buildWhen: (previous, current) =>
          previous.selectedCv != current.selectedCv,
      builder: (context, state) {
        final hasFile = state.selectedCv != null;
        return GestureDetector(
          onTap: () async {
            final FilePickerResult? result = await FilePicker.platform
                .pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg'],
                );

            if (result != null) {
              if (context.mounted) {
                context.read<ApplyJobCubit>().doIntent(
                  CvFilePickedEvent(result.files.single),
                );
              }
            }
          },
          child: DottedBorder(
            options: RoundedRectDottedBorderOptions(
              color: theme.colorScheme.secondary.withValues(alpha: 0.1),
              strokeWidth: 1.5,
              dashPattern: const [8, 4],
              radius: const Radius.circular(16),
              padding: const EdgeInsets.all(AppMeasurements.paddingLarge),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  if (hasFile) ...[
                    Icon(
                      Icons.insert_drive_file,
                      color: theme.colorScheme.primary,
                      size: 40,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      state.selectedCv!.name,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${(state.selectedCv!.size / 1024).toStringAsFixed(0)} Kb",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                  ] else ...[
                    Icon(
                      Icons.cloud_upload_outlined,
                      color: AppColors.black[40]!.withValues(alpha: 0.5),
                      size: 40,
                    ),
                    const SizedBox(height: AppMeasurements.paddingMedium),
                    Text(
                      local.formatDocPdfJpg,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppMeasurements.paddingSmall),
                    Text(
                      local.browseFiles,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
