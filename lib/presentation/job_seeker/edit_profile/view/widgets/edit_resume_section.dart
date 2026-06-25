import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/widgets/custom_elevated_button_loading.dart';
import 'package:jobify_project/generated/l10n.dart';
import '../../view_model/edit_job_seeker_profile_cubit.dart';
import '../../view_model/edit_job_seeker_profile_state.dart';
import '../../view_model/edit_job_seeker_profile_event.dart';

class EditResumeSection extends StatefulWidget {
  const EditResumeSection({super.key});

  @override
  State<EditResumeSection> createState() => _EditResumeSectionState();
}

class _EditResumeSectionState extends State<EditResumeSection> {
  String? _selectedFilePath;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFilePath = result.files.single.path;
      });
    }
  }

  String get _fileName {
    if (_selectedFilePath == null) return '';
    // Handle both / and \ path separators
    final parts = _selectedFilePath!.split(RegExp(r'[/\\]'));
    return parts.last;
  }

  String get _fileExtension {
    final name = _fileName;
    if (name.contains('.')) return name.split('.').last.toUpperCase();
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final isDark = context.theme.brightness == Brightness.dark;

    return BlocBuilder<EditJobSeekerProfileCubit, EditJobSeekerProfileState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(AppMeasurements.paddingLarge),
          decoration: BoxDecoration(
            color: isDark ? context.surfaceColor : AppColors.white,
            borderRadius: BorderRadius.circular(AppMeasurements.radiusMedium),
            border: Border.all(
              color: context.onSurfaceColor.withValues(alpha: 0.05),
            ),
            boxShadow: [
              BoxShadow(
                color: context.theme.shadowColor.withValues(alpha: 0.04),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Upload Area ──
              InkWell(
                onTap: _pickFile,
                borderRadius: BorderRadius.circular(AppMeasurements.radiusMedium),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppMeasurements.paddingExtraLarge,
                    horizontal: AppMeasurements.paddingLarge,
                  ),
                  decoration: BoxDecoration(
                    color: _selectedFilePath != null
                        ? context.primaryColor.withValues(alpha: 0.04)
                        : context.onSurfaceColor.withValues(alpha: 0.02),
                    borderRadius: BorderRadius.circular(AppMeasurements.radiusMedium),
                    border: Border.all(
                      color: _selectedFilePath != null
                          ? context.primaryColor.withValues(alpha: 0.3)
                          : context.onSurfaceColor.withValues(alpha: 0.12),
                      width: 1.5,
                    ),
                  ),
                  child: _selectedFilePath != null
                      ? _buildFileSelectedState(context)
                      : _buildUploadPromptState(context, local),
                ),
              ),
              const SizedBox(height: AppMeasurements.paddingLarge),

              // ── Upload Button ──
              CustomElevatedButtonLoading(
                widthButton: double.infinity,
                textButton: local.uploadResumeBtn,
                isLoading: state.isLoading,
                textStyleButton: context.titleMedium?.copyWith(
                  color: context.onPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
                onPressed: _selectedFilePath == null
                    ? null
                    : () {
                        context.read<EditJobSeekerProfileCubit>().doIntent(
                          UploadResumeEvent(_selectedFilePath!),
                        );
                      },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUploadPromptState(BuildContext context, AppLocalizations local) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: context.primaryColor.withValues(alpha: 0.08),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.cloud_upload_outlined,
            size: 28,
            color: context.primaryColor,
          ),
        ),
        const SizedBox(height: AppMeasurements.paddingMedium),
        Text(
          local.tapToUploadNewResume,
          style: context.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.onSurfaceColor,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "PDF, DOC, DOCX",
          style: context.bodySmall?.copyWith(
            color: context.onSurfaceColor.withValues(alpha: 0.4),
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildFileSelectedState(BuildContext context) {
    return Row(
      children: [
        // ── File Type Badge ──
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                context.primaryColor,
                context.primaryColor.withValues(alpha: 0.7),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              _fileExtension,
              style: context.labelSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppMeasurements.paddingSmall + 4),
        // ── File Info ──
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _fileName,
                style: context.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.onSurfaceColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                "Ready to upload",
                style: context.bodySmall?.copyWith(
                  color: AppColors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        // ── Change Button ──
        InkWell(
          onTap: _pickFile,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: context.onSurfaceColor.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "Change",
              style: context.labelMedium?.copyWith(
                color: context.onSurfaceColor.withValues(alpha: 0.6),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
