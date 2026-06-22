import 'package:flutter/material.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/widgets/custom_cached_network_image.dart';

class ChatItemWidget extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final String avatarUrl;
  final bool isVoiceMessage;
  final int unreadCount;
  final bool isRead;
  final VoidCallback? onTap;

  const ChatItemWidget({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    required this.avatarUrl,
    this.isVoiceMessage = false,
    this.unreadCount = 0,
    this.isRead = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppMeasurements.paddingMedium),
        decoration: BoxDecoration(
          color: isDark ? AppColors.black[50] : AppColors.lightGray,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.03),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Left: User Avatar
            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: CustomCachedNetworkImage(
                imageUrl: avatarUrl,
                borderRadius: BorderRadius.circular(28),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: AppMeasurements.paddingMedium),
            // Center: Name & Last Message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppMeasurements.paddingSmall - 2),
                  Row(
                    children: [
                      if (isVoiceMessage) ...[
                        Icon(
                          Icons.mic_none_rounded,
                          size: 16,
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.5,
                          ),
                        ),
                        const SizedBox(width: AppMeasurements.paddingExtraSmall),
                      ],
                      Expanded(
                        child: Text(
                          message,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.5,
                            ),
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
            const SizedBox(width: AppMeasurements.paddingMedium),
            // Right: Time & Read/Unread Status
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  time,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                ),
                const SizedBox(height: AppMeasurements.paddingSmall),
                if (unreadCount > 0)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    child: Center(
                      child: Text(
                        '$unreadCount',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  )
                else
                  Icon(
                    Icons.check_circle_outlined,
                    size: 18,
                    color: isRead
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurface.withValues(alpha: 0.3),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
