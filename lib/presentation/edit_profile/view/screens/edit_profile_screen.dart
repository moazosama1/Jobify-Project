import 'package:flutter/material.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/widgets/custom_app_bar.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/generated/l10n.dart';
import '../widgets/edit_profile_body.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: context.surfaceColor,
      appBar: CustomAppBar(
        title: local.editProfile,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: AppMeasurements.paddingSmall),
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                foregroundColor: context.onSurfaceColor.withValues(alpha: 0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppMeasurements.radiusSmall),
                ),
              ),
              child: Text(
                local.skip,
                style: context.bodyMedium?.copyWith(
                  color: context.onSurfaceColor.withValues(alpha: 0.4),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
      body: const SafeArea(
        child: EditProfileBody(),
      ),
    );
  }
}
