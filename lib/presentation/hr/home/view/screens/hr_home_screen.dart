import 'package:flutter/material.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import 'widgets/hr_home_screen_view_body.dart';

class HrHomeScreen extends StatelessWidget {
  const HrHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScreenWrapper(
      applyPadding: false, 
      body: HrHomeScreenViewBody(),
    );
  }
}
