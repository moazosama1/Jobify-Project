import 'package:flutter/material.dart';

class CategoryItemWidget extends StatelessWidget {
  final String imagePath;
  final String label;
  final Color accentColor;
  final bool isSelected;
  final VoidCallback? onTap;

  const CategoryItemWidget({
    super.key,
    required this.imagePath,
    required this.label,
    required this.accentColor,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image box
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isSelected
                    ? accentColor
                    : theme.colorScheme.outline.withValues(alpha: 0.15),
                width: isSelected ? 2.0 : 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Center(
              child: Image.asset(
                imagePath,
                width: 48,
                height: 48,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Label below the box
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: isSelected
                  ? accentColor
                  : theme.colorScheme.onSurface.withValues(alpha: 0.6),
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

