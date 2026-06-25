import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/widgets/custom_text_field.dart';
import 'package:jobify_project/core/widgets/custom_elevated_button_loading.dart';
import 'package:jobify_project/domain/entities/education_request_entity.dart';
import 'package:jobify_project/domain/entities/education_entity.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:intl/intl.dart';
import '../../view_model/edit_job_seeker_profile_cubit.dart';
import '../../view_model/edit_job_seeker_profile_state.dart';
import '../../view_model/edit_job_seeker_profile_event.dart';

class EditEducationSection extends StatelessWidget {
  const EditEducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final isDark = context.theme.brightness == Brightness.dark;

    return BlocBuilder<EditJobSeekerProfileCubit, EditJobSeekerProfileState>(
      builder: (context, state) {
        final rawEducations = state.data?.education ?? [];
        final educations = rawEducations.map((e) {
          if (e is EducationEntity) return e;
          return EducationEntity.fromMap(e as Map<String, dynamic>);
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
                        '${educations.length}',
                        style: context.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.primaryColor,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        local.education,
                        style: context.bodyMedium?.copyWith(
                          color: context.onSurfaceColor.withValues(alpha: 0.6),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  _buildAddButton(context, local.addEducation, () {
                    _showEducationBottomSheet(context);
                  }),
                ],
              ),
              if (educations.isNotEmpty) ...[
                const SizedBox(height: AppMeasurements.paddingMedium),
                ...educations.asMap().entries.map((entry) {
                  final index = entry.key;
                  final edu = entry.value;
                  return Column(
                    children: [
                      if (index > 0)
                        Divider(
                          color: context.onSurfaceColor.withValues(alpha: 0.08),
                          height: 1,
                        ),
                      _buildEducationCard(context, edu),
                    ],
                  );
                }),
              ] else ...[
                const SizedBox(height: AppMeasurements.paddingLarge),
                _buildEmptyState(
                  context,
                  Icons.school_outlined,
                  local.education,
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildEducationCard(BuildContext context, EducationEntity edu) {
    final dateRange = _formatDateRange(edu);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppMeasurements.paddingSmall,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Icon ──
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
              Icons.school_outlined,
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
                  edu.degree,
                  style: context.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.onSurfaceColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${edu.fieldOfStudy} • ${edu.institution}',
                  style: context.bodyMedium?.copyWith(
                    color: context.onSurfaceColor.withValues(alpha: 0.7),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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
                      if (edu.isCurrent) ...[
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
                onTap: () => _showEducationBottomSheet(context, education: edu),
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
                    DeleteEducationEvent(edu.id),
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

  String _formatDateRange(EducationEntity edu) {
    final start = edu.startDate != null
        ? DateFormat.yMMM().format(edu.startDate!)
        : '';
    if (edu.isCurrent) return '$start – Present';
    final end = edu.endDate != null
        ? DateFormat.yMMM().format(edu.endDate!)
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

  Widget _buildEmptyState(BuildContext context, IconData icon, String section) {
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

  void _showEducationBottomSheet(
    BuildContext context, {
    EducationEntity? education,
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
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: _EducationForm(
          education: education,
          cubit: context.read<EditJobSeekerProfileCubit>(),
        ),
      ),
    );
  }
}

class _EducationForm extends StatefulWidget {
  final EducationEntity? education;
  final EditJobSeekerProfileCubit cubit;

  const _EducationForm({this.education, required this.cubit});

  @override
  State<_EducationForm> createState() => _EducationFormState();
}

class _EducationFormState extends State<_EducationForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _institutionController;
  late TextEditingController _degreeController;
  late TextEditingController _fieldOfStudyController;
  late TextEditingController _descriptionController;
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isCurrent = false;

  @override
  void initState() {
    super.initState();
    _institutionController = TextEditingController(
      text: widget.education?.institution ?? '',
    );
    _degreeController = TextEditingController(
      text: widget.education?.degree ?? '',
    );
    _fieldOfStudyController = TextEditingController(
      text: widget.education?.fieldOfStudy ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.education?.description ?? '',
    );
    _startDate = widget.education?.startDate;
    _endDate = widget.education?.endDate;
    _isCurrent = widget.education?.isCurrent ?? false;
  }

  @override
  void dispose() {
    _institutionController.dispose();
    _degreeController.dispose();
    _fieldOfStudyController.dispose();
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
    final isEditing = widget.education != null;
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
              isEditing ? local.editEducation : local.addEducation,
              style: context.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppMeasurements.paddingLarge),
            CustomTextField(
              controller: _degreeController,
              label: local.degree,
              hintText: "E.g. Bachelor's",
              prefixIcon: Icon(
                Icons.school_outlined,
                color: context.primaryColor,
                size: 20,
              ),
              validator: (val) => val!.isEmpty ? local.requiredField : null,
            ),
            const SizedBox(height: AppMeasurements.paddingMedium),
            CustomTextField(
              controller: _fieldOfStudyController,
              label: local.fieldOfStudy,
              hintText: "E.g. Computer Science",
              prefixIcon: Icon(
                Icons.menu_book_outlined,
                color: context.primaryColor,
                size: 20,
              ),
              validator: (val) => val!.isEmpty ? local.requiredField : null,
            ),
            const SizedBox(height: AppMeasurements.paddingMedium),
            CustomTextField(
              controller: _institutionController,
              label: local.institution,
              hintText: "E.g. Cairo University",
              prefixIcon: Icon(
                Icons.account_balance_outlined,
                color: context.primaryColor,
                size: 20,
              ),
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
              title: Text(local.iCurrentlyStudyHere, style: context.bodyMedium),
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
              prefixIcon: Icon(
                Icons.notes_outlined,
                color: context.primaryColor,
                size: 20,
              ),
            ),
            const SizedBox(height: AppMeasurements.paddingLarge),
            CustomElevatedButtonLoading(
              widthButton: double.infinity,
              textButton: local.save,
              isLoading: false,
              onPressed: () {
                if (_formKey.currentState?.validate() == true &&
                    _startDate != null) {
                  final req = EducationRequestEntity(
                    institution: _institutionController.text,
                    degree: _degreeController.text,
                    fieldOfStudy: _fieldOfStudyController.text,
                    startDate: _startDate,
                    endDate: _endDate,
                    isCurrent: _isCurrent,
                    description: _descriptionController.text,
                  );
                  if (isEditing) {
                    widget.cubit.doIntent(
                      UpdateEducationEvent(widget.education!.id, req),
                    );
                  } else {
                    widget.cubit.doIntent(AddEducationEvent(req));
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
