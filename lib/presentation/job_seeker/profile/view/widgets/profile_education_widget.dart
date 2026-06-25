import 'package:flutter/material.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';

class ProfileEducationWidget extends StatelessWidget {
  final List<dynamic> educationList;

  const ProfileEducationWidget({
    super.key,
    required this.educationList,
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
    final secondaryColor = context.theme.colorScheme.secondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.school_outlined,
              color: secondaryColor,
              size: 22,
            ),
            const SizedBox(width: AppMeasurements.paddingSmall),
            Text(
              local.education,
              style: context.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.onSurfaceColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppMeasurements.paddingSmall),
        if (educationList.isEmpty)
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
              local.noEducationAdded,
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
            itemCount: educationList.length,
            separatorBuilder: (context, index) => const SizedBox(height: AppMeasurements.paddingSmall),
            itemBuilder: (context, index) {
              final edu = educationList[index];
              final institution = edu['institution'] as String? ?? '';
              final degree = edu['degree'] as String? ?? '';
              final fieldOfStudy = edu['fieldOfStudy'] as String? ?? '';
              final isCurrent = edu['isCurrent'] as bool? ?? false;
              final startDate = _formatDate(edu['startDate']);
              final endDate = isCurrent ? local.present : _formatDate(edu['endDate']);
              final description = edu['description'] as String? ?? '';

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
                            color: secondaryColor.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.account_balance_outlined,
                            color: secondaryColor,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: AppMeasurements.paddingMedium),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$degree in $fieldOfStudy',
                                style: context.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: context.onSurfaceColor,
                                ),
                              ),
                              const SizedBox(height: AppMeasurements.paddingExtraSmall),
                              Text(
                                institution,
                                style: context.bodyMedium?.copyWith(
                                  color: secondaryColor,
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
