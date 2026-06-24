import 'package:flutter/material.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/widgets/custom_elevated_button_loading.dart';
import 'package:jobify_project/core/widgets/custom_text_field.dart';
import 'package:jobify_project/domain/entities/requests/get_all_jobs_request_entity.dart';
import 'package:jobify_project/generated/l10n.dart';

class SearchFilterBottomSheet extends StatefulWidget {
  final GetAllJobsRequestEntity? initialFilters;
  final Function(GetAllJobsRequestEntity) onApply;
  final VoidCallback onClear;

  const SearchFilterBottomSheet({
    super.key,
    this.initialFilters,
    required this.onApply,
    required this.onClear,
  });

  @override
  State<SearchFilterBottomSheet> createState() =>
      _SearchFilterBottomSheetState();
}

class _SearchFilterBottomSheetState extends State<SearchFilterBottomSheet> {
  late final ValueNotifier<String?> _locationNotifier;
  late final ValueNotifier<String?> _employmentTypeNotifier;
  late final ValueNotifier<bool> _isRemoteNotifier;
  late final ValueNotifier<String?> _experienceLevelNotifier;

  late final TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    _locationNotifier = ValueNotifier(widget.initialFilters?.location);
    _employmentTypeNotifier = ValueNotifier(
      widget.initialFilters?.employmentType,
    );
    _isRemoteNotifier = ValueNotifier(widget.initialFilters?.isRemote ?? false);
    _experienceLevelNotifier = ValueNotifier(
      widget.initialFilters?.experienceLevel,
    );

    _locationController = TextEditingController(
      text: widget.initialFilters?.location,
    );
  }

  @override
  void dispose() {
    _locationNotifier.dispose();
    _employmentTypeNotifier.dispose();
    _isRemoteNotifier.dispose();
    _experienceLevelNotifier.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(AppMeasurements.paddingMedium),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.filters,
                    style: context.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: AppMeasurements.paddingMedium),

              // Location
              Text(
                l10n.location,
                style: context.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppMeasurements.paddingSmall),
              CustomTextField(
                controller: _locationController,
                hintText: 'e.g. Cairo, Remote',
                prefixIcon: const Icon(Icons.location_on_outlined),
                onChanged: (value) =>
                    _locationNotifier.value = value.isEmpty ? null : value,
              ),
              const SizedBox(height: AppMeasurements.paddingLarge),

              // Remote Switch
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.remote,
                    style: context.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: _isRemoteNotifier,
                    builder: (context, isRemote, child) {
                      return Switch(
                        value: isRemote,
                        onChanged: (val) => _isRemoteNotifier.value = val,
                        activeThumbColor: context.primaryColor,
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: AppMeasurements.paddingLarge),

              // Employment Type
              Text(
                l10n.employmentType,
                style: context.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppMeasurements.paddingSmall),
              ValueListenableBuilder<String?>(
                valueListenable: _employmentTypeNotifier,
                builder: (context, employmentType, child) {
                  return Wrap(
                    spacing: AppMeasurements.paddingSmall,
                    children: [
                      _buildChip(
                        l10n.categoryFullTime,
                        "full_time",
                        employmentType,
                        (val) => _employmentTypeNotifier.value = val,
                      ),
                      _buildChip(
                        l10n.categoryPartTime,
                        "part_time",
                        employmentType,
                        (val) => _employmentTypeNotifier.value = val,
                      ),
                      _buildChip(
                        l10n.contract,
                        "remote",
                        employmentType,
                        (val) => _employmentTypeNotifier.value = val,
                      ),
                      _buildChip(
                        l10n.internship,
                        "internship",
                        employmentType,
                        (val) => _employmentTypeNotifier.value = val,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: AppMeasurements.paddingLarge),

              // Experience Level
              Text(
                l10n.experienceLevel,
                style: context.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppMeasurements.paddingSmall),
              ValueListenableBuilder<String?>(
                valueListenable: _experienceLevelNotifier,
                builder: (context, experienceLevel, child) {
                  return Wrap(
                    spacing: AppMeasurements.paddingSmall,
                    children: [
                      _buildChip(
                        l10n.junior,
                        "entry_level",
                        experienceLevel,
                        (val) => _experienceLevelNotifier.value = val,
                      ),
                      _buildChip(
                        l10n.midLevel,
                        "mid_level",
                        experienceLevel,
                        (val) => _experienceLevelNotifier.value = val,
                      ),
                      _buildChip(
                        l10n.senior,
                        "senior_level",
                        experienceLevel,
                        (val) => _experienceLevelNotifier.value = val,
                      ),
                      _buildChip(
                        l10n.expert,
                        "lead_level",
                        experienceLevel,
                        (val) => _experienceLevelNotifier.value = val,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: AppMeasurements.paddingExtraLarge),

              // Actions
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButtonLoading(
                      textButton: l10n.clearFilters,
                      onPressed: () {
                        widget.onClear();
                        Navigator.pop(context);
                      },
                      isLoading: false,
                      colorButton: AppColors.lightGray,
                      textStyleButton: context.bodyMedium?.copyWith(
                        color: context.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppMeasurements.paddingMedium),
                  Expanded(
                    child: CustomElevatedButtonLoading(
                      textButton: l10n.applyFilters,
                      onPressed: () {
                        final filters = GetAllJobsRequestEntity(
                          location: _locationNotifier.value,
                          employmentType: _employmentTypeNotifier.value,
                          isRemote: _isRemoteNotifier.value,
                          experienceLevel: _experienceLevelNotifier.value,
                          category: widget.initialFilters?.category,
                        );
                        widget.onApply(filters);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(
    String label,
    String value,
    String? groupValue,
    Function(String?) onSelected,
  ) {
    final isSelected = value == groupValue;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        onSelected(selected ? value : null);
      },
      selectedColor: context.primaryColor,
      labelStyle: context.bodyMedium?.copyWith(
        color: isSelected ? AppColors.white : AppColors.gray,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected
              ? context.primaryColor
              : AppColors.gray.withValues(alpha: 0.3),
        ),
      ),
    );
  }
}
