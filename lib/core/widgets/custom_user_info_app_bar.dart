import 'package:flutter/material.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/constants/app_colors.dart';

class CustomUserInfoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String welcomeText;
  final String userNameText;
  final String? profileImageUrl;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onProfilePressed;

  const CustomUserInfoAppBar({
    super.key,
    required this.welcomeText,
    required this.userNameText,
    this.profileImageUrl,
    this.onNotificationPressed,
    this.onProfilePressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: AppMeasurements.paddingLarge,
      title: Row(
        children: [
          // Profile Avatar
          GestureDetector(
            onTap: onProfilePressed,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: theme.colorScheme.surfaceContainerHighest,
                image: profileImageUrl != null
                    ? DecorationImage(
                        image: NetworkImage(profileImageUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
                border: Border.all(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: profileImageUrl == null
                  ? Icon(
                      Icons.person_outline,
                      color: theme.colorScheme.onSurface,
                    )
                  : null,
            ),
          ),
          const SizedBox(width: AppMeasurements.paddingMedium),
          // Welcoming Texts
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  welcomeText,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  userNameText,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        // Notification Button
        Padding(
          padding: const EdgeInsets.only(right: AppMeasurements.paddingLarge),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isDark ? AppColors.black[50] : AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.shadowColor.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: IconButton(
              onPressed: onNotificationPressed,
              icon: Icon(
                Icons.notifications_none_rounded,
                color: theme.colorScheme.onSurface,
                size: 22,
              ),
              style: IconButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 8);
}
