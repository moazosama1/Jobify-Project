import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/widgets/custom_text_field.dart';
import 'package:jobify_project/core/widgets/custom_elevated_button_loading.dart';
import 'package:jobify_project/domain/entities/update_skills_request_entity.dart';
import 'package:jobify_project/generated/l10n.dart';
import '../../view_model/edit_job_seeker_profile_cubit.dart';
import '../../view_model/edit_job_seeker_profile_state.dart';
import '../../view_model/edit_job_seeker_profile_event.dart';

class EditSkillsSection extends StatefulWidget {
  const EditSkillsSection({super.key});

  @override
  State<EditSkillsSection> createState() => _EditSkillsSectionState();
}

class _EditSkillsSectionState extends State<EditSkillsSection> {
  final _skillController = TextEditingController();
  List<String> _skills = [];

  @override
  void initState() {
    super.initState();
    final cubit = context.read<EditJobSeekerProfileCubit>();
    _skills = List.from(
      (cubit.state.data?.skills ?? []).map((e) => e.toString()),
    );
  }

  @override
  void dispose() {
    _skillController.dispose();
    super.dispose();
  }

  void _addSkill() {
    final skill = _skillController.text.trim();
    if (skill.isNotEmpty && !_skills.contains(skill)) {
      setState(() {
        _skills.add(skill);
        _skillController.clear();
      });
    }
  }

  void _removeSkill(String skill) {
    setState(() {
      _skills.remove(skill);
    });
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Input Row ──
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: _skillController,
                      hintText: local.addASkill,
                      prefixIcon: Icon(
                        Icons.psychology_outlined,
                        color: context.primaryColor,
                        size: 20,
                      ),
                      onSubmitted: (_) => _addSkill(),
                    ),
                  ),
                  const SizedBox(width: AppMeasurements.paddingSmall),
                  InkWell(
                    onTap: _addSkill,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            context.primaryColor,
                            context.primaryColor.withValues(alpha: 0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: context.primaryColor.withValues(alpha: 0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppMeasurements.paddingMedium),

              // ── Skills Tags ──
              if (_skills.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppMeasurements.paddingMedium,
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.psychology_outlined,
                          size: 40,
                          color: context.onSurfaceColor.withValues(alpha: 0.15),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          local.noSkillsAdded,
                          style: context.bodyMedium?.copyWith(
                            color: context.onSurfaceColor.withValues(alpha: 0.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _skills.asMap().entries.map((entry) {
                      final skill = entry.value;
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: context.primaryColor.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: context.primaryColor.withValues(alpha: 0.15),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              skill,
                              style: context.bodyMedium?.copyWith(
                                color: context.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 6),
                            InkWell(
                              onTap: () => _removeSkill(skill),
                              borderRadius: BorderRadius.circular(10),
                              child: Icon(
                                Icons.close,
                                size: 16,
                                color: context.primaryColor.withValues(alpha: 0.6),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
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
                  context.read<EditJobSeekerProfileCubit>().doIntent(
                    UpdateSkillsEvent(
                      UpdateSkillsRequestEntity(skills: _skills),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
