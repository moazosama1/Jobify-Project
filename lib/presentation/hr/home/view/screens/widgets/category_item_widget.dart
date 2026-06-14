import 'package:flutter/material.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';

class CategoryItemWidget extends StatelessWidget {
  final String icon;
  final String label;
  final Color iconColor;
  final Color borderColor;
  final VoidCallback? onTap;

  const CategoryItemWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.borderColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon Box
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderColor, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: theme.shadowColor.withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(child: Image.asset(icon)),
          ),
          const SizedBox(height: AppMeasurements.paddingSmall),
          // Label text
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
