import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/widgets/custom_text_field.dart';
import 'package:jobify_project/core/widgets/custom_elevated_button_loading.dart';
import 'package:jobify_project/core/constants/app_images.dart';
import 'package:jobify_project/generated/l10n.dart';
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
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _aboutController;

  String? _selectedDateOfBirth;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<EditProfileCubit>();
    _nameController = TextEditingController(text: cubit.state.name);
    _phoneController = TextEditingController(text: cubit.state.contactNumber);
    _aboutController = TextEditingController(text: cubit.state.aboutYou);
    _selectedDateOfBirth = cubit.state.dateOfBirth.isNotEmpty ? cubit.state.dateOfBirth : null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDateOfBirth = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context);

    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (!state.isLoading && state.errorMessage == null) {
          _nameController.text = state.name;
          _phoneController.text = state.contactNumber;
          _aboutController.text = state.aboutYou;
          setState(() {
            _selectedDateOfBirth = state.dateOfBirth.isNotEmpty ? state.dateOfBirth : null;
          });
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: AppMeasurements.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppMeasurements.paddingMedium),
                // Avatar with Camera Icon Overlay
                Center(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        width: 110,
                        height: 110,
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          image: const DecorationImage(
                            image: AssetImage(AppImages.imageUserPhoto),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: theme.shadowColor.withValues(alpha: 0.08),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () {
                            // Pick image action
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppMeasurements.paddingLarge),

                // Personal Information header
                Center(
                  child: Text(
                    local.personalInformation,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: AppMeasurements.paddingLarge),

                // Full Name
                CustomTextField(
                  controller: _nameController,
                  label: local.fullName,
                  hintText: local.fullName,
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return local.thisFieldIsRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppMeasurements.paddingMedium),

                // Contact Number
                CustomTextField(
                  controller: _phoneController,
                  label: local.contactNumber,
                  hintText: local.contactNumber,
                  prefixIcon: Icon(
                    Icons.phone_outlined,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return local.thisFieldIsRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppMeasurements.paddingMedium),

                // Date of Birth
                Text(
                  local.dateOfBirth,
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: AppMeasurements.paddingSmall),
                InkWell(
                  onTap: () => _selectDate(context),
                  child: Container(
                    padding: const EdgeInsets.all(AppMeasurements.paddingMedium),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppMeasurements.paddingMedium),
                      border: Border.all(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 20,
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                            ),
                            const SizedBox(width: AppMeasurements.paddingMedium),
                            Text(
                              _selectedDateOfBirth ?? local.selectDateOfBirth,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: _selectedDateOfBirth != null
                                    ? theme.colorScheme.onSurface
                                    : theme.colorScheme.onSurface.withValues(alpha: 0.5),
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppMeasurements.paddingMedium),

                // About You
                Text(
                  local.aboutYou,
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: AppMeasurements.paddingSmall),
                TextFormField(
                  controller: _aboutController,
                  maxLines: 4,
                  style: theme.textTheme.bodyMedium,
                  decoration: InputDecoration(
                    hintText: "...",
                    hintStyle: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                    ),
                    contentPadding: const EdgeInsets.all(AppMeasurements.paddingMedium),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppMeasurements.paddingMedium),
                      borderSide: BorderSide(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppMeasurements.paddingMedium),
                      borderSide: BorderSide(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppMeasurements.paddingMedium),
                      borderSide: BorderSide(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppMeasurements.paddingExtraLarge),

                // Save Button
                CustomElevatedButtonLoading(
                  widthButton: double.infinity,
                  textButton: local.save,
                  isLoading: state.isLoading,
                  textStyleButton: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      context.read<EditProfileCubit>().doIntent(
                            SubmitEditProfileEvent(
                              name: _nameController.text,
                              contactNumber: _phoneController.text,
                              dateOfBirth: _selectedDateOfBirth ?? '',
                              aboutYou: _aboutController.text,
                              photoUrl: '',
                            ),
                          );
                    }
                  },
                ),
                const SizedBox(height: AppMeasurements.paddingLarge),
              ],
            ),
          ),
        );
      },
    );
  }
}
