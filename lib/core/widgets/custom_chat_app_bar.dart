import 'package:flutter/material.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/constants/end_points.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/widgets/custom_cached_network_image.dart';

class CustomChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String participantName;
  final String participantAvatar;
  final String statusText;
  final VoidCallback? onBackPressed;
  final VoidCallback? onPhonePressed;
  final VoidCallback? onVideoPressed;
  final VoidCallback? onMorePressed;
  final VoidCallback? onProfilePressed;

  const CustomChatAppBar({
    super.key,
    required this.participantName,
    required this.participantAvatar,
    required this.statusText,
    this.onBackPressed,
    this.onPhonePressed,
    this.onVideoPressed,
    this.onMorePressed,
    this.onProfilePressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Row(
        children: [
          // If we want spacing inside the appbar title row:
          const SizedBox(width: AppMeasurements.paddingLarge),
          // Back Button
          InkWell(
            onTap: onBackPressed ?? () {
              final navigator = Navigator.of(context);
              if (navigator.canPop()) {
                navigator.pop();
              }
            },
            borderRadius: BorderRadius.circular(24),
            child: Container(
              padding: const EdgeInsets.all(AppMeasurements.paddingSmall + 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: context.onSurfaceColor.withValues(alpha: 0.15),
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.arrow_back_rounded,
                size: 20,
                color: context.onSurfaceColor,
              ),
            ),
          ),
          const SizedBox(width: AppMeasurements.paddingMedium),
          Expanded(
            child: InkWell(
              onTap: onProfilePressed,
              child: Row(
                children: [
                  // Participant Avatar
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: CustomCachedNetworkImage(
                      imageUrl: participantAvatar.isNotEmpty
                          ? (participantAvatar.startsWith('http')
                              ? participantAvatar
                              : (EndPoints.awsBaseUrl + participantAvatar))
                          : 'https://i.pravatar.cc/150?img=12',
                      borderRadius: BorderRadius.circular(22),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: AppMeasurements.paddingSmall + 2),
                  // Name & Typing status
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          participantName,
                          style: context.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.onSurfaceColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          statusText,
                          style: context.bodySmall?.copyWith(
                            color: AppColors.green,
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.phone_outlined,
            color: context.onSurfaceColor.withValues(alpha: 0.6),
          ),
          onPressed: onPhonePressed ?? () {},
        ),
        IconButton(
          icon: Icon(
            Icons.videocam_outlined,
            color: context.onSurfaceColor.withValues(alpha: 0.6),
          ),
          onPressed: onVideoPressed ?? () {},
        ),
        IconButton(
          icon: Icon(
            Icons.more_vert_rounded,
            color: context.onSurfaceColor.withValues(alpha: 0.6),
          ),
          onPressed: onMorePressed ?? () {},
        ),
        const SizedBox(width: AppMeasurements.paddingMedium),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 8);
}
