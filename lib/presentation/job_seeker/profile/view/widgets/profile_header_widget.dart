import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/constants/app_images.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:jobify_project/core/router/route_names.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String name;
  final String title;

  const ProfileHeaderWidget({
    super.key,
    required this.name,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context);

    return Column(
      children: [
        // Top row (Back and Edit buttons)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => context.pop(),
              borderRadius: BorderRadius.circular(100),
              child: Container(
                padding: const EdgeInsets.all(AppMeasurements.paddingSmall),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.15),
                  ),
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: theme.colorScheme.onSurface,
                  size: 20,
                ),
              ),
            ),
            TextButton(
              onPressed: () => context.push(RouteNames.editProfile),
              child: Text(
                local.edit,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppMeasurements.paddingMedium),
        // Avatar
        Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: theme.shadowColor.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                AppImages.imageUserPhoto,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppMeasurements.paddingMedium),
        // Name
        Text(
          name,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppMeasurements.paddingExtraSmall),
        // Role title
        Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
