import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';

class SuggestedJobCard extends StatelessWidget {
  final JobEntity job;
  final double width;
  final double height;
  final double borderRadius;
  final LinearGradient? backgroundGradient;
  final Color? applyButtonColor;
  final Color logoBackgroundColor;
  final bool showBookmarkButton;
  final bool showApplyButton;
  final String applyButtonLabel;
  final VoidCallback? onTap;
  final VoidCallback? onBookmarkTap;
  final VoidCallback? onApplyTap;
  final int cardIndex;

  static const List<Map<String, Color>> _cardThemes = [
    {
      'start': Color(0xFF7B61FF),
      'end': Color(0xFF623ECA),
      'button': Color(0xFF4A1FAD),
    }, // Purple
    {
      'start': Color(0xFFCB2D3E),
      'end': Color(0xFFEF473A),
      'button': Color(0xFFB52636),
    }, // Crimson
    {
      'start': Color(0xFF2193b0),
      'end': Color(0xFF6dd5ed),
      'button': Color(0xFF1A7A93),
    }, // Blue
    {
      'start': Color(0xFFff9966),
      'end': Color(0xFFff5e62),
      'button': Color(0xFFE55458),
    }, // Pink
    {
      'start': Color(0xFF11998E),
      'end': Color(0xFF38EF7D),
      'button': Color(0xFF0F867C),
    }, // Green
    {
      'start': Color(0xFFF2994A),
      'end': Color(0xFFF2C94C),
      'button': Color(0xFFD98A43),
    }, // Orange

    {
      'start': Color(0xFF00C6FF),
      'end': Color(0xFF0072FF),
      'button': Color(0xFF005DCC),
    }, // Cyan
    {
      'start': Color(0xFF141E30),
      'end': Color(0xFF243B55),
      'button': Color(0xFF0F1724),
    }, // Deep Blue/Black
    {
      'start': Color(0xFFff7e5f),
      'end': Color(0xFFfeb47b),
      'button': Color(0xFFE67155),
    }, // Coral
    {
      'start': Color(0xFF348F50),
      'end': Color(0xFF56B4D3),
      'button': Color(0xFF2C7D46),
    }, // Emerald
  ];

  const SuggestedJobCard({
    super.key,
    required this.job,
    this.width = 280,
    this.height = 180,
    this.borderRadius = 24,
    this.backgroundGradient,
    this.applyButtonColor,
    this.logoBackgroundColor = Colors.white,
    this.showBookmarkButton = true,
    this.showApplyButton = true,
    this.applyButtonLabel = 'Apply',
    this.onTap,
    this.onBookmarkTap,
    this.onApplyTap,
    this.cardIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardTheme = _cardThemes[cardIndex % _cardThemes.length];

    final currentGradient =
        backgroundGradient ??
        LinearGradient(
          colors: [cardTheme['start']!, cardTheme['end']!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );

    final currentButtonColor = applyButtonColor ?? cardTheme['button']!;

    final card = Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(AppMeasurements.paddingMedium),
      decoration: BoxDecoration(
        gradient: currentGradient,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: cardTheme['start']!.withValues(alpha: 0.3),
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
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
                      color: currentButtonColor,
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
