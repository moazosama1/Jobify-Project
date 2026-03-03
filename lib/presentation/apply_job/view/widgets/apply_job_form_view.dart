import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/widgets/custom_elevated_button_loading.dart';
import 'package:jobify_project/core/widgets/custom_text_field.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:jobify_project/presentation/apply_job/view_model/apply_job_cubit.dart';
import 'package:jobify_project/presentation/apply_job/view_model/apply_job_event.dart';
import 'package:jobify_project/presentation/apply_job/view_model/apply_job_state.dart';
import 'package:jobify_project/presentation/apply_job/view/widgets/apply_job_upload_cv_widget.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';

class ApplyJobFormView extends StatefulWidget {
  const ApplyJobFormView({super.key});

  @override
  State<ApplyJobFormView> createState() => _ApplyJobFormViewState();
}

class _ApplyJobFormViewState extends State<ApplyJobFormView> {
  late final TextEditingController _nameController;
  late final TextEditingController _portfolioController;
  late final TextEditingController _letterController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _portfolioController = TextEditingController();
    _letterController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _portfolioController.dispose();
    _letterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return BlocBuilder<ApplyJobCubit, ApplyJobState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel(local.fullName, true, theme),
              const SizedBox(height: AppMeasurements.paddingSmall),
              CustomTextField(
                hintText: local.typeYourName,
                controller: _nameController,
              ),
              const SizedBox(height: AppMeasurements.paddingMedium),
              _buildLabel(local.websiteBlogPortfolio, true, theme),
              const SizedBox(height: AppMeasurements.paddingSmall),
              CustomTextField(
                hintText: local.typeYourPortfolioAddress,
                controller: _portfolioController,
              ),
              const SizedBox(height: AppMeasurements.paddingMedium),
              _buildLabel(local.uploadCv, true, theme),
              const SizedBox(height: AppMeasurements.paddingSmall),
              const ApplyJobUploadCvWidget(),
              const SizedBox(height: AppMeasurements.paddingMedium),
              _buildLabel(local.motivationalLetter, false, theme),
              const SizedBox(height: AppMeasurements.paddingSmall),
              CustomTextField(
                hintText: local.writeSomething,
                controller: _letterController,
              ),
              const SizedBox(height: AppMeasurements.paddingExtraLarge),
              CustomElevatedButtonLoading(
                widthButton: .infinity,
                textButton: local.applyThisJob,
                isLoading: state.apiStatus.isLoading,
                onPressed: () {
                  context.read<ApplyJobCubit>().doIntent(
                    SubmitJobApplicationEvent(
                      fullName: _nameController.text,
                      portfolioUrl: _portfolioController.text,
                      motivationalLetter: _letterController.text,
                    ),
                  );
                },
              ),
              const SizedBox(height: AppMeasurements.paddingExtraLarge),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLabel(String text, bool isRequired, ThemeData theme) {
    return RichText(
      text: TextSpan(
        text: text,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.onSurface,
        ),
        children: [
          if (isRequired)
            TextSpan(
              text: ' *',
              style: TextStyle(color: theme.colorScheme.error),
            ),
        ],
      ),
    );
  }
}
