import 'package:flutter/material.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';

class ProfileSkillsWidget extends StatelessWidget {
  final List<dynamic> skills;

  const ProfileSkillsWidget({
    super.key,
    required this.skills,
  });

  @override
  Widget build(BuildContext context) {
    final local = context.l10n;
    final isDark = context.theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.psychology_outlined,
              color: context.primaryColor,
              size: 22,
            ),
            const SizedBox(width: AppMeasurements.paddingSmall),
            Text(
              local.skills,
              style: context.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.onSurfaceColor,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: context.primaryColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${skills.length}',
                style: context.labelMedium?.copyWith(
                  color: context.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppMeasurements.paddingSmall),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppMeasurements.paddingMedium),
          decoration: BoxDecoration(
            color: isDark ? context.surfaceColor : AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: context.onSurfaceColor.withValues(alpha: 0.05),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: context.theme.shadowColor.withValues(alpha: 0.04),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: skills.isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppMeasurements.paddingSmall,
                  ),
                  child: Center(
                    child: Text(
                      local.noSkillsAdded,
                      style: context.bodyMedium?.copyWith(
                        color: context.onSurfaceColor.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                )
              : Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: skills.map((skill) {
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
                      child: Text(
                        skill.toString(),
                        style: context.bodyMedium?.copyWith(
                          color: context.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
        ),
      ],
    );
  }
}
