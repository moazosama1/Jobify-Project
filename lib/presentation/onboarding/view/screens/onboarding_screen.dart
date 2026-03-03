import 'package:flutter/material.dart';
import 'package:jobify_project/presentation/onboarding/view/widgets/onboarding_body.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: OnboardingBody()));
  }
}
