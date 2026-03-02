import 'package:flutter/material.dart';
import 'package:jobify_project/features/onboarding/presentation/view/widgets/onboarding_body.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: OnboardingBody()));
  }
}
