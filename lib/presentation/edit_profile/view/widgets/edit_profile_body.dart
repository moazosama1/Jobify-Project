import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/widgets/custom_loading_indicator.dart';
import 'package:jobify_project/core/widgets/custom_toastification.dart';
import 'package:jobify_project/core/widgets/custom_text_field.dart';
import 'package:jobify_project/core/widgets/custom_elevated_button_loading.dart';
import 'package:jobify_project/domain/entities/update_basic_info_request_entity.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:toastification/toastification.dart';
import '../../view_model/edit_profile_cubit.dart';
import '../../view_model/edit_profile_state.dart';
import '../../view_model/edit_profile_event.dart';

class EditProfileBody extends StatefulWidget {
  const EditProfileBody({super.key});

  @override
  State<EditProfileBody> createState() => _EditProfileBodyState();
}

class _EditProfileBodyState extends State<EditProfileBody> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<EditProfileCubit>();
    final user = cubit.state.profileState.data;
    _firstNameController = TextEditingController(text: user?.firstName ?? '');
    _lastNameController = TextEditingController(text: user?.lastName ?? '');
    _phoneController = TextEditingController(text: user?.phoneNumber ?? '');
    _bioController = TextEditingController(text: user?.bio ?? '');
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final isDark = context.theme.brightness == Brightness.dark;

    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state.profileState.errorMessage != null) {
          customToastification(
            context,
            ToastificationType.error,
            state.profileState.errorMessage,
          );
        } else if (state.successMessage != null) {
          customToastification(
            context,
            ToastificationType.success,
            state.successMessage,
          );
        }

        // Keep controllers updated if data loads asynchronously
        if (state.profileState.data != null && !state.profileState.isLoading) {
          final user = state.profileState.data!;
          if (_firstNameController.text != user.firstName) {
            _firstNameController.text = user.firstName;
          }
          if (_lastNameController.text != user.lastName) {
            _lastNameController.text = user.lastName;
          }
          if (_phoneController.text != user.phoneNumber) {
            _phoneController.text = user.phoneNumber;
          }
          if (_bioController.text != (user.bio ?? '')) {
            _bioController.text = user.bio ?? '';
          }
        }
      },
      builder: (context, state) {
        if (state.profileState.data == null && state.profileState.isLoading) {
          return const Center(child: CustomLoadingIndicator());
        }

        if (state.profileState.data == null && state.profileState.errorMessage != null) {
          return _buildErrorState(context, state.profileState.errorMessage!);
        }

        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppMeasurements.paddingMedium,
            vertical: AppMeasurements.paddingSmall,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Profile Header Card ──
              _buildProfileHeader(context, state),
              const SizedBox(height: AppMeasurements.paddingMedium),

              // ── Section Label ──
              _buildSectionLabel(
                context,
                Icons.person_outline,
                local.personalInformation,
              ),
              const SizedBox(height: AppMeasurements.paddingSmall),

              // ── Basic Info Fields Container ──
              Container(
                padding: const EdgeInsets.all(AppMeasurements.paddingLarge),
                decoration: BoxDecoration(
                  color: isDark ? context.surfaceColor : AppColors.white,
                  borderRadius: BorderRadius.circular(AppMeasurements.radiusMedium),
                  border: Border.all(
                    color: context.onSurfaceColor.withValues(alpha: 0.05),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: context.theme.shadowColor.withValues(alpha: 0.04),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── First & Last Name Row ──
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: _firstNameController,
                              label: local.firstName,
                              hintText: local.typeYourFirstName,
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: context.primaryColor,
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppMeasurements.paddingSmall),
                          Expanded(
                            child: CustomTextField(
                              controller: _lastNameController,
                              label: local.lastName,
                              hintText: local.typeYourLastName,
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: context.primaryColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppMeasurements.paddingMedium),

                      // ── Phone ──
                      CustomTextField(
                        controller: _phoneController,
                        label: local.contactNumber,
                        hintText: "+20 1xx xxx xxxx",
                        prefixIcon: Icon(
                          Icons.phone_outlined,
                          color: context.primaryColor,
                          size: 20,
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) return null;
                          final regex = RegExp(r'^\+?[1-9]\d{1,14}$');
                          if (!regex.hasMatch(value.trim())) {
                            return "Invalid phone number format. Must start with '+' or a digit.";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppMeasurements.paddingMedium),

                      // ── Bio ──
                      CustomTextField(
                        controller: _bioController,
                        label: local.aboutYou,
                        hintText: local.writeSomething,
                        prefixIcon: Icon(
                          Icons.notes_outlined,
                          color: context.primaryColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(height: AppMeasurements.paddingLarge),

                      // ── Save Button ──
                      CustomElevatedButtonLoading(
                        widthButton: double.infinity,
                        textButton: local.save,
                        isLoading: state.profileState.isLoading,
                        textStyleButton: context.titleMedium?.copyWith(
                          color: context.onPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            context.read<EditProfileCubit>().doIntent(
                                  UpdateBasicInfoEvent(
                                    UpdateBasicInfoRequestEntity(
                                      firstName: _firstNameController.text.trim(),
                                      lastName: _lastNameController.text.trim(),
                                      phoneNumber: _phoneController.text.trim().isNotEmpty
                                          ? _phoneController.text.trim()
                                          : null,
                                      bio: _bioController.text.trim(),
                                    ),
                                  ),
                                );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppMeasurements.paddingExtraLarge * 2),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileHeader(
    BuildContext context,
    EditProfileState state,
  ) {
    final user = state.profileState.data;
    if (user == null) return const SizedBox.shrink();

    final fullName = '${user.firstName} ${user.lastName}'.trim();
    final initials =
        '${user.firstName.isNotEmpty ? user.firstName[0] : ''}${user.lastName.isNotEmpty ? user.lastName[0] : ''}'
            .toUpperCase();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppMeasurements.paddingLarge),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.primaryColor,
            context.primaryColor.withValues(alpha: 0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppMeasurements.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: context.primaryColor.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          // ── Avatar ──
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.4),
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                initials,
                style: context.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppMeasurements.paddingMedium),
          // ── Info ──
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName,
                  style: context.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  style: context.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    user.role.toUpperCase(),
                    style: context.labelSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(BuildContext context, IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: context.primaryColor, size: 22),
        const SizedBox(width: AppMeasurements.paddingSmall),
        Text(
          label,
          style: context.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.onSurfaceColor,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppMeasurements.paddingExtraLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_off_outlined,
              size: 64,
              color: context.onSurfaceColor.withValues(alpha: 0.3),
            ),
            const SizedBox(height: AppMeasurements.paddingMedium),
            Text(
              message,
              style: context.bodyLarge?.copyWith(
                color: context.onSurfaceColor.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
