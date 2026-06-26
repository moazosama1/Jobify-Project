import 'package:flutter/material.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import 'widgets/hr_messages_screen_view_body.dart';

import 'package:jobify_project/core/widgets/custom_app_bar.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/generated/l10n.dart';

class HrMessagesScreen extends StatelessWidget {
  const HrMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return CustomScreenWrapper(
      appBar: CustomAppBar(
        title: local.chats,
        showBackButton: false, // Messages is likely a root tab, no back needed
        actions: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isDark ? AppColors.black[50] : AppColors.lightGray,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: IconButton(
                icon: Icon(
                  Icons.search_rounded,
                  size: 20,
                  color: theme.colorScheme.onSurface,
                ),
                onPressed: () {},
                padding: EdgeInsets.zero,
              ),
            ),
          ),
          const SizedBox(width: AppMeasurements.paddingSmall),
          IconButton(
            icon: Icon(
              Icons.more_vert_rounded,
              color: theme.colorScheme.onSurface,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: AppMeasurements.paddingMedium),
        ],
      ),
      body: const HrMessagesScreenViewBody(),
    );
  }
}
