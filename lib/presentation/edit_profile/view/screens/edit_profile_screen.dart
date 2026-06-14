import 'package:flutter/material.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import 'package:jobify_project/generated/l10n.dart';
import '../widgets/edit_profile_body.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 70,
        leading: Center(
          child: InkWell(
            onTap: () => Navigator.of(context).pop(),
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
        ),
        title: Text(
          local.editProfile,
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              local.skip,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: AppMeasurements.paddingSmall),
        ],
      ),
      body: const CustomScreenWrapper(
        applyPadding: false,
        body: EditProfileBody(),
      ),
    );
  }
}
