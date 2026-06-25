import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';

enum ApplicationStatus { onTheWay, delivered, canceled }

class CustomJobApplicationCard extends StatelessWidget {
  final String jobTitle;
  final String companyName;
  final String salary;
  final String location;
  final String logoUrl;
  final String employmentType;
  final String createdAt;
  final ApplicationStatus status;
  final VoidCallback onViewApplication;

  const CustomJobApplicationCard({
    super.key,
    required this.jobTitle,
    required this.companyName,
    required this.salary,
    required this.location,
    required this.logoUrl,
    this.employmentType = '',
    this.createdAt = '',
    required this.status,
    required this.onViewApplication,
  });

  @override
  Widget build(BuildContext context) {
    Color statusBgColor;
    Color statusTextColor;
    String statusText;

    switch (status) {
      case ApplicationStatus.onTheWay:
        statusBgColor = AppColors.brandLight;
        statusTextColor = AppColors.brandDefault;
        statusText = context.l10n.accepted;
        break;
      case ApplicationStatus.delivered:
        statusBgColor = AppColors.gray.withValues(alpha: 0.1);
        statusTextColor = AppColors.gray;
        statusText = context.l10n.pending;
        break;
      case ApplicationStatus.canceled:
        statusBgColor = AppColors.lightPink;
        statusTextColor = AppColors.red;
        statusText = context.l10n.rejected;
        break;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: context.onSurfaceColor.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: context.onSurfaceColor.withValues(alpha: 0.05),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onViewApplication,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: context.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: context.onSurfaceColor.withValues(alpha: 0.1),
                        ),
                      ),
                      child: logoUrl.startsWith('http')
                          ? CachedNetworkImage(
                              imageUrl: logoUrl,
                              fit: BoxFit.contain,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.business,
                                color: AppColors.gray,
                              ),
                            )
                          : Image.asset(
                              logoUrl,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                    Icons.business,
                                    color: AppColors.gray,
                                  ),
                            ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            jobTitle,
                            style: context.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            companyName,
                            style: context.bodySmall?.copyWith(
                              color: AppColors.gray,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: statusBgColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        statusText,
                        style: context.labelSmall?.copyWith(
                          color: statusTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _buildInfoChip(context, Icons.payments_outlined, salary),
                    _buildInfoChip(
                      context,
                      Icons.location_on_outlined,
                      location,
                    ),
                    if (employmentType.isNotEmpty)
                      _buildInfoChip(
                        context,
                        Icons.work_outline,
                        employmentType,
                      ),
                    if (createdAt.isNotEmpty)
                      _buildInfoChip(
                        context,
                        Icons.calendar_today_outlined,
                        _formatDate(createdAt),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(BuildContext context, IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.gray),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            text,
            style: context.bodySmall?.copyWith(color: AppColors.gray),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
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
