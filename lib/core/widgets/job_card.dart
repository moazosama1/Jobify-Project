import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';

class JobCard extends StatelessWidget {
  final JobEntity job;
  final VoidCallback? onOptionsTap;
  final void Function()? onTap;
  final Widget? trailing;

  const JobCard({
    super.key,
    required this.onTap,
    required this.job,
    this.onOptionsTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppMeasurements.paddingMedium,
          vertical: AppMeasurements.paddingMedium - 2,
        ),
        decoration: BoxDecoration(
          color: isDark ? AppColors.black[50] : AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: context.onSurfaceColor.withValues(alpha: 0.05),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: context.theme.shadowColor.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Left: Company Logo
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isDark
                    ? context.surfaceColor
                    : const Color(0xFFF0F2F5),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(AppMeasurements.paddingSmall),
              child: CachedNetworkImage(
                imageUrl: job.logoAsset,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.business, color: Colors.grey),
              ),
            ),
            const SizedBox(width: AppMeasurements.paddingMedium),
            // Center: Job Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    job.title,
                    style: context.titleMedium?.copyWith(
                      color: context.onSurfaceColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  // Metadata Row: Briefcase + Company Name, Dot, Location Pin + Location
                  Row(
                    children: [
                      Icon(
                        Icons.business_center_rounded,
                        size: 14,
                        color: context.primaryColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        job.companyName,
                        style: context.bodySmall?.copyWith(
                          color: context.onSurfaceColor.withValues(
                            alpha: 0.6,
                          ),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: AppColors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        Icons.location_on_rounded,
                        size: 14,
                        color: context.primaryColor,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          job.location,
                          style: context.bodySmall?.copyWith(
                            color: context.onSurfaceColor.withValues(
                              alpha: 0.6,
                            ),
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Right: Action Options (bookmark / save icon)
            if (trailing != null)
              trailing!
            else if (onOptionsTap != null)
              IconButton(
                icon: Icon(
                  job.isBookmarked
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded,
                  color: job.isBookmarked
                      ? context.primaryColor
                      : context.onSurfaceColor.withValues(alpha: 0.5),
                ),
                onPressed: onOptionsTap,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
          ],
        ),
      ),
    );
  }
}
