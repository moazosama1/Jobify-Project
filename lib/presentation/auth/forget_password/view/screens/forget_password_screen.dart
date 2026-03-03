import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/widgets/custom_app_bar.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import 'package:jobify_project/core/widgets/custom_toastification.dart';
import 'package:toastification/toastification.dart';
import 'package:jobify_project/presentation/auth/forget_password/view/widgets/forget_password_body.dart';
import 'package:jobify_project/presentation/auth/forget_password/view_model/forget_password_cubit.dart';
import 'package:jobify_project/presentation/auth/forget_password/view_model/forget_password_state.dart';
import 'package:jobify_project/presentation/auth/forget_password/view_model/forget_password_event.dart';
import 'package:jobify_project/generated/l10n.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          customToastification(
            context,
            ToastificationType.error,
            state.errorMessage,
          );
        }
        if (state.isSuccess) {
          context.pop(); // Navigate back to Login upon success
          customToastification(
            context,
            ToastificationType.success,
            "Password reset successfully!",
          );
        }
      },
      builder: (context, state) {
        String appBarTitle = AppLocalizations.of(context).resetPassword;
        if (state.currentStep == 1) {
          appBarTitle = AppLocalizations.of(context).verification;
        }

        return CustomScreenWrapper(
          appBar: CustomAppBar(
            title: appBarTitle,
            showBackButton: true,
            onBackPressed: () {
              if (state.currentStep > 0) {
                // If in OTP or New Password, intercept back button to go to previous step
                context.read<ForgetPasswordCubit>().doIntent(
                  BackToPreviousStepEvent(),
                );
              } else {
                // If in Email step, pop entirely
                context.pop();
              }
            },
          ),
          body: const ForgetPasswordBody(),
        );
      },
    );
  }
}
