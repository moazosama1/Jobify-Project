import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/router/route_names.dart';
import 'package:jobify_project/core/widgets/custom_search_bar.dart';
import 'package:jobify_project/presentation/hr/home/view_model/hr_home_cubit.dart';
import 'package:jobify_project/presentation/hr/home/view_model/hr_home_event.dart';

class HrSearchSectionWidget extends StatelessWidget {
  final String hintText;
  final VoidCallback onFilterPressed;

  const HrSearchSectionWidget({
    super.key,
    required this.hintText,
    required this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppMeasurements.paddingLarge,
          ),
          child: CustomSearchBar(
            hintText: hintText,
            onChanged: (value) {
              context.read<HrHomeCubit>().doIntent(SearchHrHomeEvent(value));
            },
            onFilterPressed: onFilterPressed,
          ),
        ),
        const SizedBox(height: AppMeasurements.paddingLarge),
        // HR Assistant Card
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppMeasurements.paddingLarge,
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppMeasurements.paddingLarge),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.red,
                      Color(0xFF8B0000), // A darker red shade for gradient
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppMeasurements.radiusLarge),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.red.withValues(alpha: 0.25),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                    Text(
                      "HR Assistant",
                      style: context.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: AppMeasurements.paddingSmall),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.6,
                      child: Text(
                        "Manage applications, analyze CVs, and optimize your hiring flow instantly!",
                        style: context.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppMeasurements.paddingMedium + 4),
                    ElevatedButton.icon(
                      onPressed: () => context.push(RouteNames.aiChat),
                      icon: Icon(
                        Icons.chat_bubble_outline_rounded,
                        size: 16,
                        color: AppColors.red,
                      ),
                      label: Text(
                        context.l10n.homeAiChatBannerCTA,
                        style: context.labelMedium?.copyWith(
                          color: AppColors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.red,
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
        ),
      ],
    );
  }
}
