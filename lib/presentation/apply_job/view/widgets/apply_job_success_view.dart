import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/router/route_names.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/widgets/custom_elevated_button_loading.dart';

class ApplyJobSuccessView extends StatelessWidget {
  const ApplyJobSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Column(
      children: [
        const SizedBox(height: 40),
        Container(
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                decoration: const BoxDecoration(
                  color: AppColors.brandLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: AppColors.brandDefault,
                  size: 60,
                ),
              ),
              const SizedBox(height: AppMeasurements.paddingExtraLarge),
              Text(
                local.youveApplied,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: AppMeasurements.paddingMedium),
              Text(
                local.youHaveSuccessfullyApplied,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppMeasurements.paddingExtraLarge * 2.5),
        CustomElevatedButtonLoading(
          widthButton: double.infinity,
          textButton: local.backToHome,
          textStyleButton: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
          onPressed: () {
            context.go(RouteNames.home);
          },
        ),
        const SizedBox(height: AppMeasurements.paddingMedium),
        CustomElevatedButtonLoading(
          widthButton: double.infinity,
          elevation: 0,
          colorButton: theme.colorScheme.primary.withValues(alpha: 0.1),
          textButton: local.seeAppliedJob,
          textStyleButton: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
          onPressed: () {
            context.go(RouteNames.saved);
          },
        ),
      ],
    );
  }
}
