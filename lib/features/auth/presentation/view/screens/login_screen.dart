import 'package:flutter/material.dart';
import 'package:jobify_project/core/widgets/custom_app_bar.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import 'package:jobify_project/features/auth/presentation/view/widgets/login_body.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import 'package:jobify_project/core/widgets/custom_toastification.dart';
import 'package:jobify_project/features/auth/presentation/view_model/login_cubit.dart';
import 'package:jobify_project/features/auth/presentation/view_model/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          customToastification(
            context,
            ToastificationType.error,
            state.errorMessage,
          );
        }
        if (state.isSuccess) {
          // Navigate logic
        }
      },
      child: CustomScreenWrapper(
        appBar: CustomAppBar(
          title: AppLocalizations.of(context).signIn,
          showBackButton: false,
        ),
        body: const LoginBody(),
      ),
    );
  }
}
