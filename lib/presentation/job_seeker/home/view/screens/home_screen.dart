import 'package:flutter/material.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import 'package:jobify_project/core/widgets/custom_user_info_app_bar.dart';
import 'package:jobify_project/presentation/job_seeker/home/view/screens/widgets/home_screen_view_body.dart';
import 'package:jobify_project/generated/l10n.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final local = AppLocalizations.of(context);

    return CustomScreenWrapper(
      applyPadding: false, // Enable edge-to-edge scrolling for horizontal lists
      // appBar: CustomUserInfoAppBar(
      //   welcomeText: local.welcomeUser,
      //   userNameText: local.helloUser,
      //   onNotificationPressed: () {
      //     // Notification actions here
      //   },
      // ),
      body: const HomeScreenViewBody(),
    );
  }
}
