import 'package:flutter/material.dart';
import 'package:jobify_project/core/constants/app_images.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String name;
  final String title;
  final String? bio;

  const ProfileHeaderWidget({
    super.key,
    required this.name,
    required this.title,
    this.bio,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppMeasurements.paddingMedium),
        // Avatar with modern glowing ring
        Center(
          child: Container(
            width: 106,
            height: 106,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: context.primaryColor, width: 3),
              boxShadow: [
                BoxShadow(
                  color: context.primaryColor.withValues(alpha: 0.15),
                  blurRadius: 16,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: ClipOval(
                child: Image.asset(
                  AppImages.imageUserPhoto,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: context.primaryColor.withValues(alpha: 0.1),
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: context.primaryColor,
                    ),
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
          style: context.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.onSurfaceColor,
            letterSpacing: 0.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppMeasurements.paddingSmall),
        // Role title inside a premium badge
        if (title.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: context.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: context.primaryColor.withValues(alpha: 0.15),
              ),
            ),
            child: Text(
              title.toUpperCase(),
              style: context.labelMedium?.copyWith(
                color: context.primaryColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        if (bio != null && bio!.isNotEmpty) ...[
          const SizedBox(height: AppMeasurements.paddingMedium),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppMeasurements.paddingLarge),
            child: Text(
              bio!,
              style: context.bodyMedium?.copyWith(
                color: context.onSurfaceColor.withValues(alpha: 0.7),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ],
    );
  }
}
