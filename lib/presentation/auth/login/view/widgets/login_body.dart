import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/constants/app_images.dart';
import 'package:jobify_project/core/constants/const_keys.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/utils/validations.dart';
import 'package:jobify_project/core/widgets/custom_divider.dart';
import 'package:jobify_project/core/widgets/custom_elevated_button_loading.dart';
import 'package:jobify_project/core/widgets/custom_social_button.dart';
import 'package:jobify_project/core/widgets/custom_text_field.dart';
import 'package:jobify_project/presentation/auth/login/view_model/login_cubit.dart';
import 'package:jobify_project/presentation/auth/login/view_model/login_event.dart';
import 'package:jobify_project/presentation/auth/login/view_model/login_state.dart';
import 'package:jobify_project/generated/l10n.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  late ValueNotifier<bool> _rememberMeNotifier;
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();

    _passwordController = TextEditingController();
    _rememberMeNotifier = ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.pin_drop_rounded,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: AppMeasurements.paddingMedium),
                Text(
                  ConstKeys.appName,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppMeasurements.paddingMedium),
            Text(
              local.giveCredentialToSignIn,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
            const SizedBox(height: AppMeasurements.paddingExtraLarge),

            // Inputs
            CustomTextField(
              controller: _emailController,
              label: local.email,
              hintText: local.typeYourEmail,
              prefixIcon: Icon(
                Icons.email_outlined,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
              validator: Validations.validateEmail,
            ),
            const SizedBox(height: AppMeasurements.paddingLarge),
            CustomTextField(
              controller: _passwordController,
              label: local.password,
              hintText: local.typeYourPassword,
              isPassword: true,
              prefixIcon: Icon(
                Icons.lock_outline_rounded,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
              validator: Validations.validatePassword,
            ),
            const SizedBox(height: AppMeasurements.paddingMedium),

            // Options
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: ValueListenableBuilder<bool>(
                        valueListenable: _rememberMeNotifier,
                        builder: (context, isRememberMe, child) {
                          return Checkbox(
                            value: isRememberMe,
                            onChanged: (val) {
                              if (val != null) {
                                _rememberMeNotifier.value = val;
                                context.read<LoginCubit>().onEvent(
                                  ToggleRememberMeEvent(val),
                                );
                              }
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            activeColor: theme.colorScheme.primary,
                            side: BorderSide(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.5,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: AppMeasurements.paddingSmall),
                    Text(
                      local.rememberMe,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    local.forgotPassword,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppMeasurements.paddingLarge),

            // Login Button
            BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                return CustomElevatedButtonLoading(
                  widthButton: double.infinity,
                  heightButton: 56,
                  textButton: local.signIn,
                  isLoading: state.isLoading,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<LoginCubit>().onEvent(
                        LoginSubmittedEvent(
                          email: _emailController.text,
                          password: _passwordController.text,
                        ),
                      );
                    }
                  },
                );
              },
            ),
            const SizedBox(height: AppMeasurements.paddingExtraLarge),

            // Divider
            CustomDivider(text: local.orContinueWith),
            const SizedBox(height: AppMeasurements.paddingExtraLarge),

            // Social Logins
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomSocialButton(
                  iconPath: AppImages.iconFacebook,
                  onTap: () {},
                ),
                const SizedBox(width: AppMeasurements.paddingMedium),
                CustomSocialButton(
                  iconPath: AppImages.iconGoogle,
                  onTap: () {
                    context.read<LoginCubit>().onEvent(
                      GoogleLoginClickedEvent(),
                    );
                  },
                ),
                const SizedBox(width: AppMeasurements.paddingMedium),
                CustomSocialButton(iconPath: AppImages.iconApple, onTap: () {}),
              ],
            ),
            const SizedBox(height: AppMeasurements.paddingExtraLarge),

            // Sign Up
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  local.dontHaveAccount,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    local.signUp,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppMeasurements.paddingLarge),
          ],
        ),
      ),
    );
  }
}
