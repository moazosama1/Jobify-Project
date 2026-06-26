import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/constants/app_images.dart';
import 'package:jobify_project/core/enums/gender_enum.dart';
import 'package:jobify_project/core/enums/rule_enum.dart';
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
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _ageController;
  late TextEditingController _locationController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  Gender _selectedGender = Gender.male;
  Rule _selectedRole = Rule.job_seeker;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _ageController = TextEditingController();
    _locationController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _locationController.dispose();
    _phoneController.dispose();
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
            Image.asset(
              AppImages.iconLogoFullName,
              fit: BoxFit.contain,
              height: 120,
              width: 120,
            ),
            const SizedBox(height: AppMeasurements.paddingMedium),
            Text(
              local.giveCredentialsToSignUpYourAccount,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
            const SizedBox(height: AppMeasurements.paddingExtraLarge),

            // Name fields
            CustomTextField(
              controller: _firstNameController,
              label: local.firstName,
              hintText: local.typeYourFirstName,
              textInputAction: .next,
              prefixIcon: Icon(
                Icons.person_outline_rounded,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
              validator: Validations.validateName,
            ),
            const SizedBox(width: AppMeasurements.paddingMedium),
            CustomTextField(
              controller: _lastNameController,
              label: local.lastName,
              hintText: local.typeYourLastName,
              textInputAction: .next,
              prefixIcon: Icon(
                Icons.person_outline_rounded,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
              validator: Validations.validateName,
            ),
            const SizedBox(height: AppMeasurements.paddingLarge),

            // Age
            CustomTextField(
              controller: _ageController,
              label: local.age,
              hintText: local.typeYourAge,
              textInputAction: .next,
              keyboardType: TextInputType.number,
              prefixIcon: Icon(
                Icons.cake_outlined,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
              validator: Validations.validateAge,
            ),
            const SizedBox(height: AppMeasurements.paddingLarge),

            // Location
            CustomTextField(
              controller: _locationController,
              label: local.location,
              hintText: local.typeYourLocation,
              textInputAction: .next,
              prefixIcon: Icon(
                Icons.location_on_outlined,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
              validator: Validations.validateAddress,
            ),
            const SizedBox(height: AppMeasurements.paddingLarge),

            // Phone Number
            CustomTextField(
              controller: _phoneController,
              label: local.phoneNumber,
              hintText: local.typeYourPhoneNumber,
              textInputAction: .next,
              keyboardType: TextInputType.phone,
              prefixIcon: Icon(
                Icons.phone_outlined,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
              validator: Validations.validatePhoneNumber,
            ),
            const SizedBox(height: AppMeasurements.paddingLarge),

            // Email
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

            // Password
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
            const SizedBox(height: AppMeasurements.paddingLarge),

            // Gender
            Text(
              local.gender,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppMeasurements.paddingSmall),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<Gender>(
                    value: Gender.male,
                    groupValue: _selectedGender,
                    activeColor: theme.colorScheme.primary,
                    contentPadding: EdgeInsets.zero,
                    title: Text(local.male),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedGender = value;
                        });
                      }
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<Gender>(
                    value: Gender.female,
                    groupValue: _selectedGender,
                    activeColor: theme.colorScheme.primary,
                    contentPadding: EdgeInsets.zero,
                    title: Text(local.female),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedGender = value;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppMeasurements.paddingLarge),

            // Role
            Text(
              local.role,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppMeasurements.paddingSmall),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<Rule>(
                    value: Rule.admin,
                    groupValue: _selectedRole,
                    activeColor: theme.colorScheme.primary,
                    contentPadding: EdgeInsets.zero,
                    title: Text(local.hr),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedRole = value;
                        });
                      }
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<Rule>(
                    value: Rule.job_seeker,
                    groupValue: _selectedRole,
                    activeColor: theme.colorScheme.primary,
                    contentPadding: EdgeInsets.zero,
                    title: Text(local.jobSeeker),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedRole = value;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppMeasurements.paddingExtraLarge),

            // Register Button
            BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                return CustomElevatedButtonLoading(
                  widthButton: double.infinity,
                  heightButton: 56,
                  textButton: local.signUp,
                  isLoading: state.registerStatus.isLoading,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<RegisterCubit>().doIntent(
                        RegisterSubmittedEvent(
                          firstName: _firstNameController.text,
                          lastName: _lastNameController.text,
                          age: _ageController.text,
                          location: _locationController.text,
                          phoneNumber: _phoneController.text,
                          gender: _selectedGender,
                          role: _selectedRole,
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
