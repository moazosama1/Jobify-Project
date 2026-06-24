import 'package:flutter/material.dart';
import 'package:jobify_project/core/widgets/custom_app_bar.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';
import 'package:jobify_project/generated/l10n.dart';
import '../widgets/hr_hiring_post_body.dart';

class HrHiringPostScreen extends StatelessWidget {
  final JobEntity? job;

  const HrHiringPostScreen({super.key, this.job});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: local.hiringPost,
        showBackButton: true,
      ),
      body: CustomScreenWrapper(
        applyPadding: false,
        body: HrHiringPostBody(job: job),
      ),
    );
  }
}
