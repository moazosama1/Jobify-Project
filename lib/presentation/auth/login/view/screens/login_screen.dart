import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/router/route_names.dart';
import 'package:jobify_project/core/widgets/custom_app_bar.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import 'package:jobify_project/presentation/auth/login/view/widgets/login_body.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/presentation/auth/login/view_model/login_cubit.dart';
import 'package:jobify_project/presentation/auth/login/view_model/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.isSuccess) {
          final role = state.data?.user.role;
          if (role == 'admin') {
            context.go(RouteNames.hrHome);
          } else {
            context.go(RouteNames.home);
          }
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
