import 'package:flutter/material.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/generated/l10n.dart';

class HrProfileStatsWidget extends StatelessWidget {
  final int appliedCount;
  final int reviewedCount;
  final int interviewCount;

  const HrProfileStatsWidget({
    super.key,
    required this.appliedCount,
    required this.reviewedCount,
    required this.interviewCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem(theme, appliedCount.toString(), local.applied),
        _buildDivider(theme),
        _buildStatItem(theme, reviewedCount.toString(), local.reviewed),
        _buildDivider(theme),
        _buildStatItem(theme, interviewCount.toString(), local.interview),
      ],
    );
  }

  Widget _buildStatItem(ThemeData theme, String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppMeasurements.paddingExtraSmall),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider(ThemeData theme) {
    return Container(
      width: 1,
      height: 32,
      color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
    );
  }
}
