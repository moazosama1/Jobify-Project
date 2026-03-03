import 'package:flutter/material.dart';
import 'package:jobify_project/core/widgets/custom_app_bar.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:jobify_project/presentation/apply_job/view/widgets/apply_job_body.dart';

class ApplyJobScreen extends StatelessWidget {
  const ApplyJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScreenWrapper(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context).applyJob,
        showBackButton: true,
      ),
      body: const ApplyJobBody(),
    );
  }
}
