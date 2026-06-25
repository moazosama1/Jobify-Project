import 'package:flutter/material.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';
import 'package:jobify_project/domain/entities/application_stats_entity.dart';

class ProfileStatsWidget extends StatelessWidget {
  final ApplicationStatsEntity? stats;

  const ProfileStatsWidget({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final local = context.l10n;
    final isDark = context.theme.brightness == Brightness.dark;

    final total = stats?.total ?? 0;
    final pending = stats?.pending ?? 0;
    final reviewed = stats?.reviewed ?? 0;
    final interview = stats?.interview ?? 0;
    final accepted = stats?.accepted ?? 0;
    final rejected = stats?.rejected ?? 0;

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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: _buildStatItem(context, total.toString(), local.applied),
              ),
              _buildVerticalDivider(context),
              Expanded(
                child: _buildStatItem(
                  context,
                  pending.toString(),
                  local.pending,
                ),
              ),
              _buildVerticalDivider(context),
              Expanded(
                child: _buildStatItem(
                  context,
                  reviewed.toString(),
                  local.reviewed,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Container(
              height: 1,
              width: double.infinity,
              color: context.onSurfaceColor.withValues(alpha: 0.08),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: _buildStatItem(
                  context,
                  interview.toString(),
                  local.interview,
                ),
              ),
              _buildVerticalDivider(context),
              Expanded(
                child: _buildStatItem(
                  context,
                  accepted.toString(),
                  local.accepted,
                ),
              ),
              _buildVerticalDivider(context),
              Expanded(
                child: _buildStatItem(
                  context,
                  rejected.toString(),
                  local.rejected,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String count, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildVerticalDivider(BuildContext context) {
    return Container(
      width: 1,
      height: 32,
      color: context.onSurfaceColor.withValues(alpha: 0.08),
    );
  }
}
