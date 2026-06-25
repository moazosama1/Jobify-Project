import 'package:flutter/material.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';

class ProfilePersonalInfoWidget extends StatelessWidget {
  final int age;
  final String gender;
  final String location;
  final List<dynamic> jobPreferences;

  const ProfilePersonalInfoWidget({
    super.key,
    required this.age,
    required this.gender,
    required this.location,
    required this.jobPreferences,
  });

  @override
  Widget build(BuildContext context) {
    final local = context.l10n;
    final isDark = context.theme.brightness == Brightness.dark;

    final jobPrefsStr = jobPreferences.join(', ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.badge_outlined,
              color: context.primaryColor,
              size: 22,
            ),
            const SizedBox(width: AppMeasurements.paddingSmall),
            Text(
              local.personalInformation,
              style: context.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.onSurfaceColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppMeasurements.paddingSmall),
        Container(
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
            children: [
              _buildInfoRow(context, Icons.cake_outlined, local.age, age > 0 ? age.toString() : local.notAvailable),
              _buildDivider(context),
              _buildInfoRow(context, Icons.person_outline, local.gender, gender.isNotEmpty ? gender : local.notAvailable),
              _buildDivider(context),
              _buildInfoRow(context, Icons.location_on_outlined, local.location, location.isNotEmpty ? location : local.notAvailable),
              if (jobPrefsStr.isNotEmpty) ...[
                _buildDivider(context),
                _buildInfoRow(context, Icons.work_outline, local.jobType, jobPrefsStr),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppMeasurements.paddingSmall),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: context.onSurfaceColor.withValues(alpha: 0.5),
          ),
          const SizedBox(width: AppMeasurements.paddingSmall),
          Text(
            label,
            style: context.bodyMedium?.copyWith(
              color: context.onSurfaceColor.withValues(alpha: 0.5),
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: context.bodyMedium?.copyWith(
                color: context.onSurfaceColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Divider(
      height: 1,
      color: context.onSurfaceColor.withValues(alpha: 0.08),
    );
  }
}
