import 'package:flutter/material.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import 'widgets/hr_profile_screen_view_body.dart';

class HrProfileScreen extends StatelessWidget {
  const HrProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScreenWrapper(
      body: HrProfileScreenViewBody(),
    );
  }
}
