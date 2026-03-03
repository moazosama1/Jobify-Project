import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/presentation/auth/forget_password/view_model/forget_password_cubit.dart';
import 'package:jobify_project/presentation/auth/forget_password/view_model/forget_password_state.dart';
import 'package:jobify_project/presentation/auth/forget_password/view/widgets/forget_password_email_view.dart';
import 'package:jobify_project/presentation/auth/forget_password/view/widgets/forget_password_otp_view.dart';
import 'package:jobify_project/presentation/auth/forget_password/view/widgets/forget_password_new_password_view.dart';

class ForgetPasswordBody extends StatefulWidget {
  const ForgetPasswordBody({super.key});

  @override
  State<ForgetPasswordBody> createState() => _ForgetPasswordBodyState();
}

class _ForgetPasswordBodyState extends State<ForgetPasswordBody> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listenWhen: (previous, current) =>
          previous.currentStep != current.currentStep,
      listener: (context, state) {
        if (_pageController.hasClients) {
          _pageController.animateToPage(
            state.currentStep,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
      builder: (context, state) {
        return PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            SingleChildScrollView(child: ForgetPasswordEmailView()),
            SingleChildScrollView(child: ForgetPasswordOtpView()),
            SingleChildScrollView(child: ForgetPasswordNewView()),
          ],
        );
      },
    );
  }
}
