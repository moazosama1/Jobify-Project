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
import 'package:jobify_project/presentation/auth/register/view_model/register_cubit.dart';
import 'package:jobify_project/presentation/auth/register/view_model/register_event.dart';
import 'package:jobify_project/presentation/auth/register/view_model/register_state.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:go_router/go_router.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
              local.giveCredentialsToSignUpYourAccount,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
            const SizedBox(height: AppMeasurements.paddingExtraLarge),

            // Inputs
            CustomTextField(
              controller: _fullNameController,
              label: local.fullName,
              hintText: local.typeYourName,
              textInputAction: .next,
              prefixIcon: Icon(
                Icons.person_outline_rounded,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
              validator: Validations.validateFullName,
            ),
            const SizedBox(height: AppMeasurements.paddingLarge),

            CustomTextField(
              controller: _emailController,
              label: local.email,
              hintText: local.typeYourEmail,
              textInputAction: .next,
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

            // Register Button
            BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                return CustomElevatedButtonLoading(
                  widthButton: double.infinity,
                  heightButton: 56,
                  textButton: local.signUp,
                  isLoading: state.isLoading,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<RegisterCubit>().doIntent(
                        RegisterSubmittedEvent(
                          fullName: _fullNameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          confirmPassword: _confirmPasswordController.text,
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
                    context.read<RegisterCubit>().doIntent(
                      RegisterGoogleLoginClickedEvent(),
                    );
                  },
                ),
                const SizedBox(width: AppMeasurements.paddingMedium),
                CustomSocialButton(iconPath: AppImages.iconApple, onTap: () {}),
              ],
            ),
            const SizedBox(height: AppMeasurements.paddingExtraLarge),

            // Sign In
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  local.alreadyHaveAccount,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text(
                    local.signIn,
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
