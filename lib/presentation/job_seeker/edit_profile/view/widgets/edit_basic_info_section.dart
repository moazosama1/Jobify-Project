import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/widgets/custom_text_field.dart';
import 'package:jobify_project/core/widgets/custom_elevated_button_loading.dart';
import 'package:jobify_project/domain/entities/update_basic_info_request_entity.dart';
import 'package:jobify_project/generated/l10n.dart';
import '../../view_model/edit_job_seeker_profile_cubit.dart';
import '../../view_model/edit_job_seeker_profile_state.dart';
import '../../view_model/edit_job_seeker_profile_event.dart';

class EditBasicInfoSection extends StatefulWidget {
  const EditBasicInfoSection({super.key});

  @override
  State<EditBasicInfoSection> createState() => _EditBasicInfoSectionState();
}

class _EditBasicInfoSectionState extends State<EditBasicInfoSection> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<EditJobSeekerProfileCubit>();
    final user = cubit.state.data;
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

    return BlocBuilder<EditJobSeekerProfileCubit, EditJobSeekerProfileState>(
      builder: (context, state) {
        return Container(
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
                  isLoading: state.isLoading,
                  textStyleButton: context.titleMedium?.copyWith(
                    color: context.onPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      context.read<EditJobSeekerProfileCubit>().doIntent(
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
        );
      },
    );
  }
}
