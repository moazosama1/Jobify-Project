import 'package:flutter/material.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: showBackButton
          ? Center(
              child: InkWell(
                onTap: onBackPressed ?? () => Navigator.of(context).pop(),
                borderRadius: BorderRadius.circular(
                  AppMeasurements.paddingSmall,
                ),
                child: Container(
                  padding: const EdgeInsets.all(AppMeasurements.paddingSmall),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.2),
                    ),
                    borderRadius: BorderRadius.circular(
                      AppMeasurements.paddingSmall,
                    ),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            )
          : null,
      title: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
