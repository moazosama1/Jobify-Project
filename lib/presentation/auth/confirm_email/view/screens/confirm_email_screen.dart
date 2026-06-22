import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/widgets/custom_app_bar.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import 'package:jobify_project/core/widgets/custom_toastification.dart';
import 'package:toastification/toastification.dart';
import 'package:jobify_project/presentation/auth/confirm_email/view/widgets/confirm_email_body.dart';
import 'package:jobify_project/presentation/auth/confirm_email/view_model/confirm_email_cubit.dart';
import 'package:jobify_project/presentation/auth/confirm_email/view_model/confirm_email_state.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:jobify_project/core/router/route_names.dart';

class ConfirmEmailScreen extends StatelessWidget {
  final String email;

  const ConfirmEmailScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return BlocListener<ConfirmEmailCubit, ConfirmEmailState>(
      listener: (context, state) {
        if (state.confirmEmailStatus.errorMessage != null) {
          customToastification(
            context,
            ToastificationType.error,
            state.confirmEmailStatus.errorMessage,
          );
        }
        if (state.confirmEmailStatus.data != null) {
          customToastification(
            context,
            ToastificationType.success,
            state.confirmEmailStatus.data?.message ?? "Email confirmed successfully!",
          );
          // Navigate to login page
          context.go(RouteNames.login);
        }
      },
      child: CustomScreenWrapper(
        appBar: CustomAppBar(
          title: local.confirmEmail,
          showBackButton: true,
        ),
        body: ConfirmEmailBody(email: email),
      ),
    );
  }
}
