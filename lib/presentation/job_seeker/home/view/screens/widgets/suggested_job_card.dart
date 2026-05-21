import 'package:flutter/material.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';

class SuggestedJobCard extends StatelessWidget {
  final JobEntity job;
  final VoidCallback? onBookmarkTap;
  final VoidCallback? onApplyTap;

  const SuggestedJobCard({
    super.key,
    required this.job,
    this.onBookmarkTap,
    this.onApplyTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 280,
      padding: const EdgeInsets.all(AppMeasurements.paddingMedium),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF7B61FF), // Vibrant violet-purple
            Color(0xFF623ECA), // Deep indigo
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7B61FF).withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Logo, Company & Title, Bookmark Button
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Company Logo Box
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(AppMeasurements.paddingSmall),
                child: Image.asset(job.logoAsset, fit: BoxFit.contain),
              ),
              const SizedBox(width: AppMeasurements.paddingMedium),
              // Company Name & Job Title
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      job.companyName,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.white.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      job.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // Bookmark Button
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  job.isBookmarked
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded,
                  color: AppColors.white,
                  size: 24,
                ),
                onPressed: onBookmarkTap,
              ),
            ],
          ),
          const Spacer(),
          // Middle Row: Chip Tags
          Wrap(
            spacing: AppMeasurements.paddingSmall,
            runSpacing: AppMeasurements.paddingExtraSmall,
            children: job.tags.map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppMeasurements.paddingSmall + 2,
                  vertical: AppMeasurements.paddingExtraSmall + 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  tag,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
          const Spacer(),
          // Bottom Row: Salary & Apply Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Salary
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: job.salary,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' / Year',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.white.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
              // Apply Button
              GestureDetector(
                onTap: onApplyTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppMeasurements.paddingMedium,
                    vertical: AppMeasurements.paddingSmall + 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A1FAD), // Darker contrast color
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Apply',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: AppColors.white,
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
