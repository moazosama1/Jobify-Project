import 'package:flutter/material.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';

class ProfileExperienceWidget extends StatelessWidget {
  final List<dynamic> experienceList;

  const ProfileExperienceWidget({
    super.key,
    required this.experienceList,
  });

  String _formatDate(dynamic dateValue) {
    if (dateValue == null) return '';
    if (dateValue is DateTime) {
      const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      return '${months[dateValue.month - 1]} ${dateValue.year}';
    }
    if (dateValue is String) {
      if (dateValue.isEmpty) return '';
      try {
        final dateTime = DateTime.parse(dateValue);
        const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        return '${months[dateTime.month - 1]} ${dateTime.year}';
      } catch (_) {
        return dateValue.split('T').first;
      }
    }
    return dateValue.toString();
  }

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
              Icons.work_history_outlined,
              color: context.primaryColor,
              size: 22,
            ),
            const SizedBox(width: AppMeasurements.paddingSmall),
            Text(
              local.experience,
              style: context.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.onSurfaceColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppMeasurements.paddingSmall),
        if (experienceList.isEmpty)
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
            child: Text(
              local.noExperienceAdded,
              style: context.bodyMedium?.copyWith(
                color: context.onSurfaceColor.withValues(alpha: 0.5),
              ),
              textAlign: TextAlign.center,
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: experienceList.length,
            separatorBuilder: (context, index) => const SizedBox(height: AppMeasurements.paddingSmall),
            itemBuilder: (context, index) {
              final exp = experienceList[index];
              final company = exp['company'] as String? ?? '';
              final position = exp['position'] as String? ?? '';
              final isCurrent = exp['isCurrent'] as bool? ?? false;
              final startDate = _formatDate(exp['startDate']);
              final endDate = isCurrent ? local.present : _formatDate(exp['endDate']);
              final description = exp['description'] as String? ?? '';

              return Container(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: context.primaryColor.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.business_outlined,
                            color: context.primaryColor,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: AppMeasurements.paddingMedium),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                position,
                                style: context.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: context.onSurfaceColor,
                                ),
                              ),
                              const SizedBox(height: AppMeasurements.paddingExtraSmall),
                              Text(
                                company,
                                style: context.bodyMedium?.copyWith(
                                  color: context.primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '$startDate - $endDate',
                          style: context.bodySmall?.copyWith(
                            color: context.onSurfaceColor.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                    if (description.isNotEmpty) ...[
                      const SizedBox(height: AppMeasurements.paddingSmall),
                      Text(
                        description,
                        style: context.bodySmall?.copyWith(
                          color: context.onSurfaceColor.withValues(alpha: 0.7),
                          height: 1.3,
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
      ],
    );
  }
}
