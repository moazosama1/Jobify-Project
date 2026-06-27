import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';
import 'package:jobify_project/core/router/route_names.dart';
import 'package:jobify_project/core/cubit/core_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeAiChatBannerWidget extends StatelessWidget {
  const HomeAiChatBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final coreState = context.read<CoreCubit>().state;
    final isHr = coreState is CoreStateChanged && coreState.user != null && coreState.user!.role.toLowerCase() == 'hr';

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppMeasurements.paddingMedium,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background Gradient Container
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppMeasurements.paddingLarge),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  context.primaryColor,
                  context.primaryColor.withValues(alpha: 0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(AppMeasurements.radiusLarge),
              boxShadow: [
                BoxShadow(
                  color: context.primaryColor.withValues(alpha: 0.25),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Sparkle Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.auto_awesome,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: AppMeasurements.paddingExtraSmall + 2),
                      Text(
                        context.l10n.aiChatIntelligence,
                        style: context.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppMeasurements.paddingMedium),
                // Banner Title
                Text(
                  isHr ? "Try Jobify HR Copilot" : context.l10n.homeAiChatBannerTitle,
                  style: context.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: AppMeasurements.paddingSmall),
                // Banner Subtitle
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.6,
                  child: Text(
                    isHr
                        ? "Draft job descriptions, design templates, and screen candidates instantly."
                        : context.l10n.homeAiChatBannerSubtitle,
                    style: context.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: AppMeasurements.paddingMedium + 4),
                // Action Button
                ElevatedButton.icon(
                  onPressed: () => context.push(RouteNames.aiChat),
                  icon: Icon(
                    Icons.chat_bubble_outline_rounded,
                    size: 16,
                    color: context.primaryColor,
                  ),
                  label: Text(
                    isHr ? "Start Hiring Help" : context.l10n.homeAiChatBannerCTA,
                    style: context.labelMedium?.copyWith(
                      color: context.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: context.primaryColor,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppMeasurements.paddingMedium + 4,
                      vertical: AppMeasurements.paddingSmall + 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Background Decorative Icon
          Positioned(
            right: -8,
            bottom: -12,
            child: Icon(
              Icons.auto_awesome,
              size: 120,
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
        ],
      ),
    );
  }
}
