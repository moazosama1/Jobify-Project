import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/utils/validations.dart';
import 'package:jobify_project/core/widgets/custom_elevated_button_loading.dart';
import 'package:jobify_project/core/widgets/custom_text_field.dart';
import 'package:jobify_project/presentation/auth/forget_password/view_model/forget_password_cubit.dart';
import 'package:jobify_project/presentation/auth/forget_password/view_model/forget_password_event.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:jobify_project/presentation/auth/forget_password/view_model/forget_password_state.dart';

class ForgetPasswordEmailView extends StatefulWidget {
  const ForgetPasswordEmailView({super.key});

  @override
  State<ForgetPasswordEmailView> createState() =>
      _ForgetPasswordEmailViewState();
}

class _ForgetPasswordEmailViewState extends State<ForgetPasswordEmailView> {
  late TextEditingController _emailController;
  final _emailFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
      builder: (context, state) {
        return Form(
          key: _emailFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                local.pleaseEnterEmailForReset,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
              const SizedBox(height: AppMeasurements.paddingExtraLarge),
              CustomTextField(
                controller: _emailController,
                label: local.email,
                hintText: "jonathansmith@gmail.com",
                textInputAction: TextInputAction.done,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
                validator: Validations.validateEmail,
              ),
              const SizedBox(height: AppMeasurements.paddingExtraLarge),
              CustomElevatedButtonLoading(
                widthButton: double.infinity,
                heightButton: 56,
                textButton: local.send,
                isLoading: state.isLoading,
                onPressed: () {
                  if (_emailFormKey.currentState!.validate()) {
                    context.read<ForgetPasswordCubit>().doIntent(
                      SendEmailCodeEvent(_emailController.text),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
