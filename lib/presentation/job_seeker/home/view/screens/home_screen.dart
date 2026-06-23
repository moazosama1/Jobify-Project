import 'package:flutter/material.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import 'package:jobify_project/presentation/job_seeker/home/view/screens/widgets/home_screen_view_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return const CustomScreenWrapper(
      applyPadding: false, 
      body: HomeScreenViewBody(),
    );
  }
}
