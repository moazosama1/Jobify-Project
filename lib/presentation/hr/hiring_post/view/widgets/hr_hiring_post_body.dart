import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:jobify_project/core/constants/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/widgets/custom_text_field.dart';
import 'package:jobify_project/core/widgets/custom_elevated_button_loading.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';
import 'package:jobify_project/core/widgets/custom_toastification.dart';
import 'package:toastification/toastification.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';
import '../../view_model/hr_hiring_post_cubit.dart';
import '../../view_model/hr_hiring_post_state.dart';
import '../../view_model/hr_hiring_post_event.dart';

class HrHiringPostBody extends StatefulWidget {
  final JobEntity? job;
  static VoidCallback? onJobPosted;

  const HrHiringPostBody({super.key, this.job});

  @override
  State<HrHiringPostBody> createState() => _HrHiringPostBodyState();
}

class _HrHiringPostBodyState extends State<HrHiringPostBody> {
  final _formKey = GlobalKey<FormState>();
  bool _useProfileImage = false;

  late TextEditingController _companyNameController;
  late TextEditingController _companyLogoController;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _responsibilitiesController;
  late TextEditingController _requirementsController;
  late TextEditingController _preferredQualificationsController;
  late TextEditingController _locationController;
  late TextEditingController _salaryMinController;
  late TextEditingController _salaryMaxController;
  late TextEditingController _deadlineController;
  late TextEditingController _skillsRequiredController;
  late TextEditingController _categoryController;
  late TextEditingController _openingsController;

  final ValueNotifier<String> _selectedEmploymentType = ValueNotifier<String>(
    'full_time',
  );
  final ValueNotifier<String> _selectedExperienceLevel = ValueNotifier<String>(
    'mid_level',
  );
  final ValueNotifier<bool> _isRemote = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    final hasJob = widget.job != null;
    if (hasJob) {
      final logo = widget.job!.logoAsset;
      if (logo.contains('users/profiles') || logo.contains('profiles')) {
        _useProfileImage = true;
      }
    }
    _companyNameController = TextEditingController(
      text: hasJob ? widget.job!.companyName : 'Route',
    );
    _companyLogoController = TextEditingController(
      text: hasJob ? widget.job!.logoAsset : '',
    );
    _titleController = TextEditingController(
      text: hasJob ? widget.job!.title : '',
    );
    _descriptionController = TextEditingController(
      text: hasJob ? widget.job!.description : '',
    );
    _responsibilitiesController = TextEditingController(
      text: hasJob ? widget.job!.responsibilities.join(', ') : '',
    );
    _requirementsController = TextEditingController(
      text: hasJob ? widget.job!.requirements.join(', ') : '',
    );
    _preferredQualificationsController = TextEditingController(
      text: hasJob ? widget.job!.preferredQualifications.join(', ') : '',
    );
    _locationController = TextEditingController(
      text: hasJob ? widget.job!.location : '',
    );
    _salaryMinController = TextEditingController(
      text: hasJob ? widget.job!.salaryMin.toString() : '',
    );
    _salaryMaxController = TextEditingController(
      text: hasJob ? widget.job!.salaryMax.toString() : '',
    );
    _deadlineController = TextEditingController(
      text: hasJob
          ? (widget.job!.applicationDeadline.length >= 10
                ? widget.job!.applicationDeadline.substring(0, 10)
                : widget.job!.applicationDeadline)
          : '',
    );
    _skillsRequiredController = TextEditingController(
      text: hasJob ? widget.job!.skillsRequired.join(', ') : '',
    );
    _categoryController = TextEditingController(
      text: hasJob ? widget.job!.category : '',
    );
    _openingsController = TextEditingController(
      text: hasJob ? widget.job!.openings.toString() : '1',
    );

    if (hasJob) {
      _selectedEmploymentType.value = widget.job!.employmentType.isNotEmpty
          ? widget.job!.employmentType
          : 'full_time';
      _selectedExperienceLevel.value = widget.job!.experienceLevel.isNotEmpty
          ? widget.job!.experienceLevel
          : 'mid_level';
      _isRemote.value = widget.job!.isRemote;
    }
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _companyLogoController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _responsibilitiesController.dispose();
    _requirementsController.dispose();
    _preferredQualificationsController.dispose();
    _locationController.dispose();
    _salaryMinController.dispose();
    _salaryMaxController.dispose();
    _deadlineController.dispose();
    _skillsRequiredController.dispose();
    _categoryController.dispose();
    _openingsController.dispose();
    _selectedEmploymentType.dispose();
    _selectedExperienceLevel.dispose();
    _isRemote.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _deadlineController.text = picked.toIso8601String().substring(0, 10);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = context.l10n;

    final employmentTypes = [
      {'value': 'full_time', 'label': local.categoryFullTime},
      {'value': 'part_time', 'label': local.categoryPartTime},
      {'value': 'freelance', 'label': local.categoryFreelance},
      {'value': 'contract', 'label': 'Contract'},
      {'value': 'internship', 'label': 'Internship'},
    ];

    final experienceLevels = [
      {'value': 'entry_level', 'label': 'Entry Level'},
      {'value': 'mid_level', 'label': 'Mid Level'},
      {'value': 'senior_level', 'label': 'Senior Level'},
      {'value': 'lead', 'label': 'Lead'},
      {'value': 'manager', 'label': 'Manager'},
    ];

    return BlocConsumer<HrHiringPostCubit, HrHiringPostState>(
      listener: (context, state) {
        if (state.createJobStatus.data != null) {
          customToastification(
            context,
            ToastificationType.success,
            state.createJobStatus.data?.message ?? local.success,
          );

          HrHiringPostBody.onJobPosted?.call();
          Navigator.of(context).pop();
        } else if (state.createJobStatus.errorMessage != null) {
          customToastification(
            context,
            ToastificationType.error,
            state.createJobStatus.errorMessage,
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
                // 1. Company snapshot section
                _buildSectionHeader(local.companySnapshot),
                const SizedBox(height: AppMeasurements.paddingMedium),
                CustomTextField(
                  controller: _companyNameController,
                  label: local.companyName,
                  hintText: local.companyName,
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? local.thisFieldIsRequired
                      : null,
                ),
                const SizedBox(height: AppMeasurements.paddingMedium),
                FormField<String>(
                  initialValue: _companyLogoController.text,
                  validator: (value) {
                    if (_companyLogoController.text.trim().isEmpty) {
                      return local.thisFieldIsRequired;
                    }
                    return null;
                  },
                  builder: (formFieldState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel(local.companyLogo),
                        const SizedBox(height: AppMeasurements.paddingSmall),
                        Row(
                          children: [
                            Checkbox(
                              value: _useProfileImage,
                              onChanged: (val) {
                                final profileImg = state.userProfileImage;
                                if (val == true && (profileImg == null || profileImg.isEmpty)) {
                                  customToastification(
                                    context,
                                    ToastificationType.warning,
                                    "No profile picture found. Please upload one in your profile first.",
                                  );
                                  return;
                                }
                                setState(() {
                                  _useProfileImage = val ?? false;
                                  if (_useProfileImage) {
                                    _companyLogoController.text = profileImg ?? '';
                                    formFieldState.didChange(profileImg);
                                  } else {
                                    _companyLogoController.clear();
                                    formFieldState.didChange(null);
                                  }
                                });
                              },
                              activeColor: context.primaryColor,
                            ),
                            Text(
                              "Use Profile Picture",
                              style: context.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppMeasurements.paddingSmall),
                        GestureDetector(
                          onTap: _useProfileImage
                              ? null
                              : () async {
                                  final result = await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp', 'heic', 'heif'],
                                  );
                                  if (result != null && result.files.single.path != null) {
                                    setState(() {
                                      _companyLogoController.text = result.files.single.path!;
                                      formFieldState.didChange(result.files.single.path);
                                    });
                                  }
                                },
                          child: Container(
                            height: 120,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: context.surfaceColor,
                              borderRadius: BorderRadius.circular(AppMeasurements.paddingMedium),
                              border: Border.all(
                                color: formFieldState.hasError
                                    ? Colors.red
                                    : context.onSurfaceColor.withValues(alpha: 0.2),
                              ),
                            ),
                            child: _companyLogoController.text.isEmpty
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_photo_alternate_outlined,
                                        size: 40,
                                        color: context.primaryColor,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Import from device',
                                        style: context.bodyMedium?.copyWith(
                                          color: context.primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                : Stack(
                                    children: [
                                      Center(
                                        child: (_companyLogoController.text.isNotEmpty &&
                                                !_companyLogoController.text.startsWith('http') &&
                                                !_companyLogoController.text.startsWith('Jobify'))
                                            ? Image.file(
                                                File(_companyLogoController.text),
                                                fit: BoxFit.contain,
                                                height: 100,
                                              )
                                            : Image.network(
                                                _companyLogoController.text.startsWith('Jobify')
                                                    ? "${EndPoints.awsBaseUrl}${_companyLogoController.text}"
                                                    : _companyLogoController.text,
                                                fit: BoxFit.contain,
                                                height: 100,
                                                errorBuilder: (context, error, stackTrace) {
                                                  return const Icon(
                                                    Icons.business,
                                                    size: 40,
                                                    color: Colors.grey,
                                                  );
                                                },
                                              ),
                                      ),
                                      if (!_useProfileImage)
                                        Positioned(
                                          top: 8,
                                          right: 8,
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: context.primaryColor,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.edit,
                                              size: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                          ),
                        ),
                        if (formFieldState.hasError) ...[
                          const SizedBox(height: 6),
                          Text(
                            formFieldState.errorText ?? '',
                            style: const TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ],
                      ],
                    );
                  },
                ),
                const SizedBox(height: AppMeasurements.paddingLarge),

                // 2. Job specification section
                _buildSectionHeader(local.hiringPost),
                const SizedBox(height: AppMeasurements.paddingMedium),
                CustomTextField(
                  controller: _titleController,
                  label: local.jobTitle,
                  hintText: local.jobTitle,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return local.thisFieldIsRequired;
                    }
                    if (value.trim().length <= 3) {
                      return local.titleTooShort;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppMeasurements.paddingMedium),
                _buildLabel(local.jobDescription),
                const SizedBox(height: AppMeasurements.paddingSmall),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 4,
                  style: context.bodyMedium,
                  decoration: _buildInputDecoration(local.jobDescription),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return local.thisFieldIsRequired;
                    }
                    if (value.trim().length < 50) {
                      return local.descriptionTooShort;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppMeasurements.paddingMedium),
                CustomTextField(
                  controller: _locationController,
                  label: local.location,
                  hintText: local.location,
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? local.thisFieldIsRequired
                      : null,
                ),
                const SizedBox(height: AppMeasurements.paddingMedium),
                CustomTextField(
                  controller: _categoryController,
                  label: local.category,
                  hintText: local.category,
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? local.thisFieldIsRequired
                      : null,
                ),
                const SizedBox(height: AppMeasurements.paddingMedium),
                CustomTextField(
                  controller: _openingsController,
                  label: local.openings,
                  hintText: local.openings,
                  keyboardType: TextInputType.number,
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? local.thisFieldIsRequired
                      : null,
                ),
                const SizedBox(height: AppMeasurements.paddingMedium),

                // Dropdowns & Switch
                _buildLabel(local.employmentType),
                const SizedBox(height: AppMeasurements.paddingSmall),
                ValueListenableBuilder<String>(
                  valueListenable: _selectedEmploymentType,
                  builder: (context, val, _) {
                    return DropdownButtonFormField<String>(
                      initialValue: val,
                      decoration: _buildInputDecoration(local.employmentType),
                      items: employmentTypes.map((type) {
                        return DropdownMenuItem<String>(
                          value: type['value'],
                          child: Text(
                            type['label']!,
                            style: context.bodyMedium,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null)
                          _selectedEmploymentType.value = value;
                      },
                    );
                  },
                ),
                const SizedBox(height: AppMeasurements.paddingMedium),

                _buildLabel(local.experienceLevel),
                const SizedBox(height: AppMeasurements.paddingSmall),
                ValueListenableBuilder<String>(
                  valueListenable: _selectedExperienceLevel,
                  builder: (context, val, _) {
                    return DropdownButtonFormField<String>(
                      initialValue: val,
                      decoration: _buildInputDecoration(local.experienceLevel),
                      items: experienceLevels.map((lvl) {
                        return DropdownMenuItem<String>(
                          value: lvl['value'],
                          child: Text(lvl['label']!, style: context.bodyMedium),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null)
                          _selectedExperienceLevel.value = value;
                      },
                    );
                  },
                ),
                const SizedBox(height: AppMeasurements.paddingMedium),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      local.isRemote,
                      style: context.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: _isRemote,
                      builder: (context, remote, _) {
                        return Switch(
                          value: remote,
                          //  activeThumbColor: COlors.,
                          onChanged: (value) => _isRemote.value = value,
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: AppMeasurements.paddingLarge),

                // 3. Salary & Deadline section
                _buildSectionHeader(local.jobDetails),
                const SizedBox(height: AppMeasurements.paddingMedium),
                CustomTextField(
                  controller: _salaryMinController,
                  label: local.salaryRangeMin,
                  hintText: local.salaryRangeMin,
                  keyboardType: TextInputType.number,
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? local.thisFieldIsRequired
                      : null,
                ),
                const SizedBox(height: AppMeasurements.paddingMedium),
                CustomTextField(
                  controller: _salaryMaxController,
                  label: local.salaryRangeMax,
                  hintText: local.salaryRangeMax,
                  keyboardType: TextInputType.number,
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? local.thisFieldIsRequired
                      : null,
                ),
                const SizedBox(height: AppMeasurements.paddingMedium),
                _buildLabel(local.applicationDeadline),
                const SizedBox(height: AppMeasurements.paddingSmall),
                InkWell(
                  onTap: () => _selectDate(context),
                  child: IgnorePointer(
                    child: CustomTextField(
                      controller: _deadlineController,
                      hintText: 'YYYY-MM-DD',
                      validator: (value) =>
                          (value == null || value.trim().isEmpty)
                          ? local.thisFieldIsRequired
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: AppMeasurements.paddingLarge),

                // 4. Comma-separated list sections
                _buildSectionHeader(local.requirementsAndDetails),
                const SizedBox(height: AppMeasurements.paddingMedium),
                CustomTextField(
                  controller: _skillsRequiredController,
                  label: local.skillsRequired,
                  hintText: 'e.g. Node.js, REST API',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return local.thisFieldIsRequired;
                    }
                    final items = value.split(',');
                    for (var item in items) {
                      if (item.trim().length < 5) {
                        return "Item '${item.trim()}' must be at least 5 chars";
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppMeasurements.paddingMedium),
                CustomTextField(
                  controller: _responsibilitiesController,
                  label: local.responsibilities,
                  hintText: 'e.g. Build REST APIs, Maintain backend',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return local.thisFieldIsRequired;
                    }
                    final items = value.split(',');
                    for (var item in items) {
                      if (item.trim().length < 5) {
                        return "Item '${item.trim()}' must be at least 5 chars";
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppMeasurements.paddingMedium),
                CustomTextField(
                  controller: _requirementsController,
                  label: local.requirements,
                  hintText: 'e.g. MongoDB, Node.js, Express',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return local.thisFieldIsRequired;
                    }
                    final items = value.split(',');
                    for (var item in items) {
                      if (item.trim().length < 5) {
                        return "Item '${item.trim()}' must be at least 5 chars";
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppMeasurements.paddingMedium),
                CustomTextField(
                  controller: _preferredQualificationsController,
                  label: local.preferredQualifications,
                  hintText: 'e.g. TypeScript, Microservices',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return local.thisFieldIsRequired;
                    }
                    final items = value.split(',');
                    for (var item in items) {
                      if (item.trim().length < 5) {
                        return "Item '${item.trim()}' must be at least 5 chars";
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppMeasurements.paddingExtraLarge),

                // Post Button
                CustomElevatedButtonLoading(
                  widthButton: double.infinity,
                  textButton: local.post,
                  isLoading: state.createJobStatus.isLoading,
                  textStyleButton: context.titleMedium?.copyWith(
                    color: context.onPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      if (widget.job != null) {
                        context.read<HrHiringPostCubit>().doIntent(
                          HrHiringPostUpdateEvent(
                            jobId: widget.job!.id,
                            originalJob: widget.job!,
                            companyName: _companyNameController.text,
                            companyLogo: _companyLogoController.text,
                            title: _titleController.text,
                            description: _descriptionController.text,
                            responsibilities: _responsibilitiesController.text,
                            requirements: _requirementsController.text,
                            preferredQualifications:
                                _preferredQualificationsController.text,
                            location: _locationController.text,
                            employmentType: _selectedEmploymentType.value,
                            experienceLevel: _selectedExperienceLevel.value,
                            salaryMin:
                                int.tryParse(_salaryMinController.text) ?? 0,
                            salaryMax:
                                int.tryParse(_salaryMaxController.text) ?? 0,
                            applicationDeadline: _deadlineController.text,
                            skillsRequired: _skillsRequiredController.text,
                            category: _categoryController.text,
                            openings:
                                int.tryParse(_openingsController.text) ?? 1,
                            isRemote: _isRemote.value,
                          ),
                        );
                      } else {
                        context.read<HrHiringPostCubit>().doIntent(
                          HrHiringPostSubmitEvent(
                            companyName: _companyNameController.text,
                            companyLogo: _companyLogoController.text,
                            title: _titleController.text,
                            description: _descriptionController.text,
                            responsibilities: _responsibilitiesController.text,
                            requirements: _requirementsController.text,
                            preferredQualifications:
                                _preferredQualificationsController.text,
                            location: _locationController.text,
                            employmentType: _selectedEmploymentType.value,
                            experienceLevel: _selectedExperienceLevel.value,
                            salaryMin:
                                int.tryParse(_salaryMinController.text) ?? 0,
                            salaryMax:
                                int.tryParse(_salaryMaxController.text) ?? 0,
                            applicationDeadline: _deadlineController.text,
                            skillsRequired: _skillsRequiredController.text,
                            category: _categoryController.text,
                            openings:
                                int.tryParse(_openingsController.text) ?? 1,
                            isRemote: _isRemote.value,
                          ),
                        );
                      }
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

  Widget _buildSectionHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.primaryColor,
          ),
        ),
        const SizedBox(height: AppMeasurements.paddingExtraSmall),
        Divider(
          color: context.primaryColor.withValues(alpha: 0.3),
          thickness: 1,
        ),
      ],
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: context.titleSmall?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: context.bodyMedium?.copyWith(
        color: context.onSurfaceColor.withValues(alpha: 0.5),
      ),
      contentPadding: const EdgeInsets.all(AppMeasurements.paddingMedium),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppMeasurements.paddingMedium),
        borderSide: BorderSide(
          color: context.onSurfaceColor.withValues(alpha: 0.2),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppMeasurements.paddingMedium),
        borderSide: BorderSide(
          color: context.onSurfaceColor.withValues(alpha: 0.2),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppMeasurements.paddingMedium),
        borderSide: BorderSide(color: context.primaryColor),
      ),
    );
  }
}
