import 'package:flutter/material.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/widgets/custom_cached_network_image.dart';

class CustomUserInfoAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String welcomeText;
  final String userNameText;
  final String? profileImageUrl;
  final VoidCallback? onSavedPressed;
  final VoidCallback? onProfilePressed;
  final IconData? actionIcon;

  const CustomUserInfoAppBar({
    super.key,
    required this.welcomeText,
    required this.userNameText,
    this.profileImageUrl,
    this.onSavedPressed,
    this.onProfilePressed,
    this.actionIcon,
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
      title: GestureDetector(
        onTap: onProfilePressed,
        behavior: HitTestBehavior.opaque,
        child: Row(
          children: [
            // Profile Avatar
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: theme.colorScheme.surfaceContainerHighest,
                  border: Border.all(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
                child: profileImageUrl != null && profileImageUrl!.isNotEmpty
                    ? CustomCachedNetworkImage(
                        imageUrl: profileImageUrl!,
                        fit: BoxFit.cover,
                      )
                    : Icon(
                        Icons.person_outline,
                        color: theme.colorScheme.onSurface,
                      ),
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
              onPressed: onSavedPressed,
              icon: Icon(
                actionIcon ?? Icons.bookmark_outline,
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
