import 'package:flutter/material.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';

class CustomSocialButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback onTap;

  const CustomSocialButton({
    super.key,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppMeasurements.paddingMedium),
      child: Container(
        width: 80,
        height: 56,
        decoration: BoxDecoration(
          border: Border.all(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
          ),
          borderRadius: BorderRadius.circular(AppMeasurements.paddingMedium),
        ),
        child: Center(child: Image.asset(iconPath, width: 24, height: 24)),
      ),
    );
  }
}
