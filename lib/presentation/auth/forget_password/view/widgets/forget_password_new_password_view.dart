import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/utils/validations.dart';
import 'package:jobify_project/core/widgets/custom_elevated_button_loading.dart';
import 'package:jobify_project/core/widgets/custom_text_field.dart';
import 'package:jobify_project/presentation/auth/forget_password/view_model/forget_password_cubit.dart';
import 'package:jobify_project/presentation/auth/forget_password/view_model/forget_password_event.dart';
import 'package:jobify_project/presentation/auth/forget_password/view_model/forget_password_state.dart';
import 'package:jobify_project/generated/l10n.dart';

class ForgetPasswordNewView extends StatefulWidget {
  const ForgetPasswordNewView({super.key});

  @override
  State<ForgetPasswordNewView> createState() => _ForgetPasswordNewViewState();
}

class _ForgetPasswordNewViewState extends State<ForgetPasswordNewView> {
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  final _passwordFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
      builder: (context, state) {
        return Form(
          key: _passwordFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                local.pleaseEnterNewPassword,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
              const SizedBox(height: AppMeasurements.paddingExtraLarge),
              CustomTextField(
                controller: _passwordController,
                label: local.password,
                hintText: local.typeYourPassword,
                textInputAction: .next,
                isPassword: true,
                prefixIcon: Icon(
                  Icons.lock_outline_rounded,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
                validator: Validations.validatePassword,
              ),
              const SizedBox(height: AppMeasurements.paddingLarge),
              CustomTextField(
                controller: _confirmPasswordController,
                label: local.confirmPassword,
                hintText: local.typeYourPassword,
                textInputAction: .done,
                isPassword: true,
                prefixIcon: Icon(
                  Icons.lock_outline_rounded,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
                validator: (val) {
                  return Validations.validateConfirmPassword(
                    val,
                    _passwordController.text,
                  );
                },
              ),
              const SizedBox(height: AppMeasurements.paddingExtraLarge),
              CustomElevatedButtonLoading(
                widthButton: double.infinity,
                heightButton: 56,
                textButton: local.resetNow,
                isLoading: state.isLoading,
                onPressed: () {
                  if (_passwordFormKey.currentState!.validate()) {
                    context.read<ForgetPasswordCubit>().doIntent(
                      ResetPasswordSubmittedEvent(
                        newPassword: _passwordController.text,
                        confirmPassword: _confirmPasswordController.text,
                      ),
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
