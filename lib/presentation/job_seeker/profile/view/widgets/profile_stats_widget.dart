import 'package:flutter/material.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';

class ProfileStatsWidget extends StatelessWidget {
  final int appliedCount;
  final int reviewedCount;
  final int interviewCount;

  const ProfileStatsWidget({
    super.key,
    required this.appliedCount,
    required this.reviewedCount,
    required this.interviewCount,
  });

  @override
  Widget build(BuildContext context) {
    final local = context.l10n;
    final isDark = context.theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppMeasurements.paddingMedium,
        horizontal: AppMeasurements.paddingSmall,
      ),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem(context, appliedCount.toString(), local.applied),
          _buildDivider(context),
          _buildStatItem(context, reviewedCount.toString(), local.reviewed),
          _buildDivider(context),
          _buildStatItem(context, interviewCount.toString(), local.interview),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: context.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.primaryColor,
          ),
        ),
        const SizedBox(height: AppMeasurements.paddingExtraSmall),
        Text(
          label,
          style: context.bodyMedium?.copyWith(
            color: context.onSurfaceColor.withValues(alpha: 0.5),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Container(
      width: 1,
      height: 32,
      color: context.onSurfaceColor.withValues(alpha: 0.08),
    );
  }
}
