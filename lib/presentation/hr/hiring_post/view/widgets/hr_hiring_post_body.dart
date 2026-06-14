import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/widgets/custom_text_field.dart';
import 'package:jobify_project/core/widgets/custom_elevated_button_loading.dart';
import 'package:jobify_project/generated/l10n.dart';
import '../../view_model/hr_hiring_post_cubit.dart';
import '../../view_model/hr_hiring_post_state.dart';
import '../../view_model/hr_hiring_post_event.dart';

class HrHiringPostBody extends StatefulWidget {
  const HrHiringPostBody({super.key});

  @override
  State<HrHiringPostBody> createState() => _HrHiringPostBodyState();
}

class _HrHiringPostBodyState extends State<HrHiringPostBody> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _jobTitleController;
  late TextEditingController _yearsController;
  late TextEditingController _educationController;
  late TextEditingController _requirementsController;

  String? _selectedPositionLevel;
  String? _selectedLocation;

  @override
  void initState() {
    super.initState();
    _jobTitleController = TextEditingController();
    _yearsController = TextEditingController();
    _educationController = TextEditingController();
    _requirementsController = TextEditingController();
  }

  @override
  void dispose() {
    _jobTitleController.dispose();
    _yearsController.dispose();
    _educationController.dispose();
    _requirementsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context);

    final positionLevels = ['Junior', 'Mid-Level', 'Senior', 'Lead', 'Manager'];
    final locations = ['Remote', 'Hybrid', 'On-site', 'Cairo, Egypt', 'Alexandria, Egypt'];

    return BlocConsumer<HrHiringPostCubit, HrHiringPostState>(
      listener: (context, state) {
        if (!state.isLoading && state.errorMessage == null && state.jobTitle.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(local.success),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pop();
        } else if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: theme.colorScheme.error,
            ),
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(AppMeasurements.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: _jobTitleController,
                  label: local.jobTitle,
                  hintText: local.jobTitle,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return local.thisFieldIsRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppMeasurements.paddingMedium),

                // Position Level Dropdown
                Text(
                  local.positionLevel,
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: AppMeasurements.paddingSmall),
                DropdownButtonFormField<String>(
                  value: _selectedPositionLevel,
                  hint: Text(
                    local.positionLevel,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: AppMeasurements.paddingMedium,
                      horizontal: AppMeasurements.paddingMedium,
                    ),
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
                  items: positionLevels.map((level) {
                    return DropdownMenuItem<String>(
                      value: level,
                      child: Text(level, style: theme.textTheme.bodyMedium),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedPositionLevel = val;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return local.thisFieldIsRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppMeasurements.paddingMedium),

                CustomTextField(
                  controller: _yearsController,
                  label: local.yearsOfExperience,
                  hintText: local.yearsOfExperience,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return local.thisFieldIsRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppMeasurements.paddingMedium),

                // Location Dropdown
                Text(
                  local.location,
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: AppMeasurements.paddingSmall),
                DropdownButtonFormField<String>(
                  value: _selectedLocation,
                  hint: Text(
                    local.location,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: AppMeasurements.paddingMedium,
                      horizontal: AppMeasurements.paddingMedium,
                    ),
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
                  items: locations.map((loc) {
                    return DropdownMenuItem<String>(
                      value: loc,
                      child: Text(loc, style: theme.textTheme.bodyMedium),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedLocation = val;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return local.thisFieldIsRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppMeasurements.paddingMedium),

                CustomTextField(
                  controller: _educationController,
                  label: local.education,
                  hintText: local.education,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return local.thisFieldIsRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppMeasurements.paddingMedium),

                // Job Requirements (Multiline)
                Text(
                  local.jobRequirements,
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: AppMeasurements.paddingSmall),
                TextFormField(
                  controller: _requirementsController,
                  maxLines: 4,
                  style: theme.textTheme.bodyMedium,
                  decoration: InputDecoration(
                    hintText: local.jobRequirements,
                    hintStyle: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
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
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return local.thisFieldIsRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppMeasurements.paddingExtraLarge),

                // Post Button
                CustomElevatedButtonLoading(
                  widthButton: double.infinity,
                  textButton: local.post,
                  isLoading: state.isLoading,
                  textStyleButton: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      context.read<HrHiringPostCubit>().doIntent(
                            HrHiringPostSubmitEvent(
                              jobTitle: _jobTitleController.text,
                              positionLevel: _selectedPositionLevel ?? '',
                              yearsOfExperience: _yearsController.text,
                              location: _selectedLocation ?? '',
                              education: _educationController.text,
                              jobRequirements: _requirementsController.text,
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
