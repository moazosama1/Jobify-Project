import 'package:flutter/material.dart';
import 'package:jobify_project/core/widgets/custom_app_bar.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import 'package:jobify_project/generated/l10n.dart';
import '../widgets/hr_hiring_post_body.dart';

class HrHiringPostScreen extends StatelessWidget {
  const HrHiringPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: local.hiringPost,
        showBackButton: true,
      ),
      body: const CustomScreenWrapper(
        applyPadding: false,
        body: HrHiringPostBody(),
      ),
    );
  }
}
