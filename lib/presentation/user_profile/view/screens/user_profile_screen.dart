import 'package:flutter/material.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import 'package:jobify_project/core/widgets/custom_app_bar.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';
import 'package:jobify_project/presentation/user_profile/view/widgets/user_profile_view_body.dart';

class UserProfileScreen extends StatelessWidget {
  final String userId;

  const UserProfileScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return CustomScreenWrapper(
      appBar: CustomAppBar(
        title: context.l10n.profile,
        showBackButton: true,
      ),
      body: const UserProfileViewBody(),
    );
  }
}
