import 'package:flutter/material.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';

class SuggestedJobCard extends StatelessWidget {
  final JobEntity job;
  final double width;
  final double height;
  final double borderRadius;
  final LinearGradient backgroundGradient;
  final Color applyButtonColor;
  final Color logoBackgroundColor;
  final bool showBookmarkButton;
  final bool showApplyButton;
  final String applyButtonLabel;
  final VoidCallback? onTap;
  final VoidCallback? onBookmarkTap;
  final VoidCallback? onApplyTap;

  const SuggestedJobCard({
    super.key,
    required this.job,
    this.width = 280,
    this.height = 180,
    this.borderRadius = 24,
    this.backgroundGradient = const LinearGradient(
      colors: [Color(0xFF7B61FF), Color(0xFF623ECA)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    this.applyButtonColor = const Color(0xFF4A1FAD),
    this.logoBackgroundColor = Colors.white,
    this.showBookmarkButton = true,
    this.showApplyButton = true,
    this.applyButtonLabel = 'Apply',
    this.onTap,
    this.onBookmarkTap,
    this.onApplyTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final card = Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(AppMeasurements.paddingMedium),
      decoration: BoxDecoration(
        gradient: backgroundGradient,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7B61FF).withOpacity(0.3),
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
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: logoBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(AppMeasurements.paddingSmall),
                child: Image.asset(job.logoAsset, fit: BoxFit.contain),
              ),
              const SizedBox(width: AppMeasurements.paddingMedium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      job.companyName,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.white.withOpacity(0.7),
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
              if (showBookmarkButton)
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
                  color: AppColors.white.withOpacity(0.15),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                        color: AppColors.white.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              if (showApplyButton)
                GestureDetector(
                  onTap: onApplyTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppMeasurements.paddingMedium,
                      vertical: AppMeasurements.paddingSmall + 2,
                    ),
                    decoration: BoxDecoration(
                      color: applyButtonColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          applyButtonLabel,
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

    if (onTap == null) {
      return card;
    }

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onTap,
        child: card,
      ),
    );
  }
}
