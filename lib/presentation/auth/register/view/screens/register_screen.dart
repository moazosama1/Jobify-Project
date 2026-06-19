import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/widgets/custom_app_bar.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import 'package:jobify_project/core/widgets/custom_toastification.dart';
import 'package:toastification/toastification.dart';
import 'package:jobify_project/presentation/auth/register/view/widgets/register_body.dart';
import 'package:jobify_project/presentation/auth/register/view_model/register_cubit.dart';
import 'package:jobify_project/presentation/auth/register/view_model/register_state.dart';
import 'package:jobify_project/generated/l10n.dart';

import 'package:jobify_project/core/router/route_names.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.registerStatus.errorMessage != null) {
          customToastification(
            context,
            ToastificationType.error,
            state.registerStatus.errorMessage,
          );
        }
        if (state.registerStatus.data != null) {
          customToastification(
            context,
            ToastificationType.success,
            "User created successfully ,please confirmed your email ",
          );
          context.pushReplacement(
            RouteNames.confirmEmail,
            extra: state.registerStatus.data?.user?.email ?? "",
          );
        }
      },
      child: CustomScreenWrapper(
        appBar: CustomAppBar(
          title: AppLocalizations.of(context).signUp,
          showBackButton: true,
        ),
        body: const RegisterBody(),
      ),
    );
  }
}
