import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';

class JobCard extends StatelessWidget {
  final JobEntity job;
  final VoidCallback? onOptionsTap;
  final void Function()? onTap;
  final void Function()? onApplyTap;
  final Widget? trailing;

  const JobCard({
    super.key,
    required this.onTap,
    required this.job,
    this.onOptionsTap,
    this.onApplyTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;

    return Slidable(
      key: ValueKey(job.id),
      endActionPane: (onApplyTap != null || onOptionsTap != null)
          ? ActionPane(
              motion: const ScrollMotion(),
              extentRatio: 0.45,
              children: [
                if (onOptionsTap != null)
                  SlidableAction(
                    onPressed: (_) => onOptionsTap!(),
                    backgroundColor: job.isBookmarked 
                        ? AppColors.red 
                        : (isDark ? AppColors.black[100]! : const Color(0xFFF0F2F5)),
                    foregroundColor: job.isBookmarked 
                        ? AppColors.white 
                        : context.onSurfaceColor,
                    icon: job.isBookmarked
                        ? Icons.delete_outline_rounded
                        : Icons.bookmark_border_rounded,
                    label: job.isBookmarked ? context.l10n.delete : context.l10n.save,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                if (onApplyTap != null)
                  SlidableAction(
                    onPressed: (_) => onApplyTap!(),
                    backgroundColor: context.primaryColor,
                    foregroundColor: context.onPrimaryColor,
                    icon: Icons.send_rounded,
                    label: context.l10n.apply,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
              ],
            )
          : null,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
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
                width: 40,
                height: 40,
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
              const SizedBox(width: 12),
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
                    const SizedBox(height: 4),
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
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if (job.applicationDeadline.isNotEmpty)
                          _buildChip(
                            context,
                            Icons.calendar_today_outlined,
                            _formatDate(job.applicationDeadline),
                          ),
                        if (job.employmentType.isNotEmpty)
                          _buildChip(context, Icons.work_outline, job.employmentType),
                      ],
                    ),
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(BuildContext context, IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: context.primaryColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: context.primaryColor),
          const SizedBox(width: 4),
          Text(
            text,
            style: context.bodySmall?.copyWith(
              color: context.primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String isoDate) {
    try {
      final date = DateTime.parse(isoDate);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return isoDate;
    }
  }
}
