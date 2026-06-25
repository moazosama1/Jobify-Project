import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/widgets/custom_text_field.dart';
import 'package:jobify_project/core/widgets/custom_elevated_button_loading.dart';
import 'package:jobify_project/domain/entities/experience_request_entity.dart';
import 'package:jobify_project/domain/entities/experience_entity.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:intl/intl.dart';
import '../../view_model/edit_job_seeker_profile_cubit.dart';
import '../../view_model/edit_job_seeker_profile_state.dart';
import '../../view_model/edit_job_seeker_profile_event.dart';

class EditExperienceSection extends StatelessWidget {
  const EditExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final isDark = context.theme.brightness == Brightness.dark;

    return BlocBuilder<EditJobSeekerProfileCubit, EditJobSeekerProfileState>(
      builder: (context, state) {
        final rawExperiences = state.data?.experience ?? [];
        final experiences = rawExperiences.map((e) {
          if (e is ExperienceEntity) return e;
          return ExperienceEntity.fromMap(e as Map<String, dynamic>);
        }).toList();

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header Row ──
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '${experiences.length}',
                        style: context.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.primaryColor,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        local.experience,
                        style: context.bodyMedium?.copyWith(
                          color: context.onSurfaceColor.withValues(alpha: 0.6),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  _buildAddButton(context, local.addExperience, () {
                    _showExperienceBottomSheet(context);
                  }),
                ],
              ),
              if (experiences.isNotEmpty) ...[
                const SizedBox(height: AppMeasurements.paddingMedium),
                ...experiences.asMap().entries.map((entry) {
                  final index = entry.key;
                  final exp = entry.value;
                  return Column(
                    children: [
                      if (index > 0)
                        Divider(
                          color: context.onSurfaceColor.withValues(alpha: 0.08),
                          height: 1,
                        ),
                      _buildExperienceCard(context, exp),
                    ],
                  );
                }),
              ] else ...[
                const SizedBox(height: AppMeasurements.paddingLarge),
                _buildEmptyState(
                  context,
                  Icons.business_center_outlined,
                  local.experience,
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildExperienceCard(BuildContext context, ExperienceEntity exp) {
    final dateRange = _formatDateRange(exp);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppMeasurements.paddingSmall),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Timeline Dot ──
          Container(
            width: 42,
            height: 42,
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  context.primaryColor.withValues(alpha: 0.15),
                  context.primaryColor.withValues(alpha: 0.08),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.business_center_outlined,
              color: context.primaryColor,
              size: 20,
            ),
          ),
          const SizedBox(width: AppMeasurements.paddingSmall + 4),
          // ── Content ──
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exp.position,
                  style: context.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.onSurfaceColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  exp.company,
                  style: context.bodyMedium?.copyWith(
                    color: context.onSurfaceColor.withValues(alpha: 0.7),
                  ),
                ),
                if (dateRange.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 13,
                        color: context.onSurfaceColor.withValues(alpha: 0.4),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        dateRange,
                        style: context.bodySmall?.copyWith(
                          color: context.onSurfaceColor.withValues(alpha: 0.5),
                        ),
                      ),
                      if (exp.isCurrent) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.green.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Current',
                            style: context.labelSmall?.copyWith(
                              color: AppColors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ],
            ),
          ),
          // ── Actions ──
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () => _showExperienceBottomSheet(context, experience: exp),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Icon(
                    Icons.edit_outlined,
                    size: 18,
                    color: context.onSurfaceColor.withValues(alpha: 0.4),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  context.read<EditJobSeekerProfileCubit>().doIntent(
                    DeleteExperienceEvent(exp.id),
                  );
                },
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Icon(
                    Icons.delete_outline,
                    size: 18,
                    color: context.errorColor.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDateRange(ExperienceEntity exp) {
    final start = exp.startDate != null
        ? DateFormat.yMMM().format(exp.startDate!)
        : '';
    if (exp.isCurrent) return '$start – Present';
    final end = exp.endDate != null
        ? DateFormat.yMMM().format(exp.endDate!)
        : '';
    if (start.isEmpty && end.isEmpty) return '';
    return '$start – $end';
  }

  Widget _buildAddButton(
    BuildContext context,
    String label,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppMeasurements.radiusSmall),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: context.primaryColor.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(AppMeasurements.radiusSmall),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, color: context.primaryColor, size: 16),
            const SizedBox(width: 4),
            Text(
              label,
              style: context.labelMedium?.copyWith(
                color: context.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    IconData icon,
    String section,
  ) {
    return Center(
      child: Column(
        children: [
          Icon(
            icon,
            size: 40,
            color: context.onSurfaceColor.withValues(alpha: 0.15),
          ),
          const SizedBox(height: 8),
          Text(
            "No $section added yet",
            style: context.bodyMedium?.copyWith(
              color: context.onSurfaceColor.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }

  void _showExperienceBottomSheet(
    BuildContext context, {
    ExperienceEntity? experience,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppMeasurements.radiusLarge),
        ),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
        ),
        child: _ExperienceForm(
          experience: experience,
          cubit: context.read<EditJobSeekerProfileCubit>(),
        ),
      ),
    );
  }
}

class _ExperienceForm extends StatefulWidget {
  final ExperienceEntity? experience;
  final EditJobSeekerProfileCubit cubit;

  const _ExperienceForm({this.experience, required this.cubit});

  @override
  State<_ExperienceForm> createState() => _ExperienceFormState();
}

class _ExperienceFormState extends State<_ExperienceForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _companyController;
  late TextEditingController _positionController;
  late TextEditingController _descriptionController;
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isCurrent = false;

  @override
  void initState() {
    super.initState();
    _companyController =
        TextEditingController(text: widget.experience?.company ?? '');
    _positionController =
        TextEditingController(text: widget.experience?.position ?? '');
    _descriptionController =
        TextEditingController(text: widget.experience?.description ?? '');
    _startDate = widget.experience?.startDate;
    _endDate = widget.experience?.endDate;
    _isCurrent = widget.experience?.isCurrent ?? false;
  }

  @override
  void dispose() {
    _companyController.dispose();
    _positionController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart
          ? (_startDate ?? DateTime.now())
          : (_endDate ?? DateTime.now()),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.experience != null;
    final local = AppLocalizations.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppMeasurements.paddingLarge),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Drag Handle ──
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: context.onSurfaceColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: AppMeasurements.paddingMedium),
            Text(
              isEditing ? local.editExperience : local.addExperience,
              style: context.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppMeasurements.paddingLarge),
            CustomTextField(
              controller: _positionController,
              label: local.position,
              hintText: "E.g. Software Engineer",
              prefixIcon: Icon(Icons.work_outline, color: context.primaryColor, size: 20),
              validator: (val) => val!.isEmpty ? local.requiredField : null,
            ),
            const SizedBox(height: AppMeasurements.paddingMedium),
            CustomTextField(
              controller: _companyController,
              label: local.company,
              hintText: "E.g. Google",
              prefixIcon: Icon(Icons.business_outlined, color: context.primaryColor, size: 20),
              validator: (val) => val!.isEmpty ? local.requiredField : null,
            ),
            const SizedBox(height: AppMeasurements.paddingMedium),
            Row(
              children: [
                Expanded(
                  child: _buildDateSelector(
                    context,
                    local.startDate,
                    _startDate,
                    () => _selectDate(context, true),
                  ),
                ),
                const SizedBox(width: AppMeasurements.paddingSmall),
                Expanded(
                  child: _isCurrent
                      ? _buildDateSelector(
                          context,
                          local.endDate,
                          null,
                          null,
                          displayText: local.present,
                        )
                      : _buildDateSelector(
                          context,
                          local.endDate,
                          _endDate,
                          () => _selectDate(context, false),
                        ),
                ),
              ],
            ),
            CheckboxListTile(
              title: Text(
                local.iCurrentlyWorkHere,
                style: context.bodyMedium,
              ),
              value: _isCurrent,
              contentPadding: EdgeInsets.zero,
              activeColor: context.primaryColor,
              onChanged: (val) {
                setState(() {
                  _isCurrent = val ?? false;
                  if (_isCurrent) _endDate = null;
                });
              },
            ),
            const SizedBox(height: AppMeasurements.paddingSmall),
            CustomTextField(
              controller: _descriptionController,
              label: local.description,
              hintText: local.writeSomething,
              prefixIcon: Icon(Icons.notes_outlined, color: context.primaryColor, size: 20),
            ),
            const SizedBox(height: AppMeasurements.paddingLarge),
            CustomElevatedButtonLoading(
              widthButton: double.infinity,
              textButton: local.save,
              isLoading: false,
              onPressed: () {
                if (_formKey.currentState?.validate() == true &&
                    _startDate != null) {
                  final req = ExperienceRequestEntity(
                    company: _companyController.text,
                    position: _positionController.text,
                    startDate: _startDate,
                    endDate: _endDate,
                    isCurrent: _isCurrent,
                    description: _descriptionController.text,
                  );
                  if (isEditing) {
                    widget.cubit.doIntent(
                      UpdateExperienceEvent(widget.experience!.id, req),
                    );
                  } else {
                    widget.cubit.doIntent(AddExperienceEvent(req));
                  }
                  Navigator.pop(context);
                }
              },
            ),
            const SizedBox(height: AppMeasurements.paddingLarge),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector(
    BuildContext context,
    String label,
    DateTime? date,
    VoidCallback? onTap, {
    String? displayText,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppMeasurements.radiusSmall),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppMeasurements.paddingSmall + 4,
          vertical: AppMeasurements.paddingSmall + 4,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppMeasurements.radiusSmall),
          border: Border.all(
            color: context.onSurfaceColor.withValues(alpha: 0.15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: context.labelSmall?.copyWith(
                color: context.onSurfaceColor.withValues(alpha: 0.5),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 14,
                  color: context.primaryColor,
                ),
                const SizedBox(width: 6),
                Text(
                  displayText ??
                      (date != null
                          ? DateFormat.yMMM().format(date)
                          : "Select"),
                  style: context.bodyMedium?.copyWith(
                    color: date != null || displayText != null
                        ? context.onSurfaceColor
                        : context.onSurfaceColor.withValues(alpha: 0.4),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
