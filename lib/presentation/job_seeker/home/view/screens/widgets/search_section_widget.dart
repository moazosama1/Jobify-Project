import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/router/route_names.dart';

class SearchSectionWidget extends StatelessWidget {
  final String hintText;
  final bool hasActiveFilters;
  final VoidCallback onFilterPressed;

  const SearchSectionWidget({
    super.key,
    required this.hintText,
    this.hasActiveFilters = false,
    required this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppMeasurements.paddingMedium,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              context.push(RouteNames.search);
            },
            child: Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.lightGray.withValues(alpha: 0.5),
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                border: Border.all(
                  color: AppColors.gray.withValues(alpha: 0.5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppMeasurements.paddingSmall,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: AppColors.gray.withValues(alpha: 0.5),
                    ),
                    const SizedBox(width: AppMeasurements.paddingSmall),
                    Text(
                      context.l10n.searchJob,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.gray.withValues(alpha: 0.4),
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(
                        AppMeasurements.paddingSmall,
                      ),
                      child: InkWell(
                        onTap: onFilterPressed,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: hasActiveFilters
                                ? theme.colorScheme.primary
                                : theme.colorScheme.primary.withValues(
                                    alpha: 0.05,
                                  ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.tune_rounded,
                            color: hasActiveFilters
                                ? theme.colorScheme.onPrimary
                                : theme.colorScheme.primary,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: AppMeasurements.paddingLarge),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                height: 170,
                padding: const EdgeInsets.all(AppMeasurements.paddingLarge),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF4D75FF),
                      Color.fromARGB(255, 14, 62, 165),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(
                        255,
                        14,
                        62,
                        165,
                      ).withValues(alpha: 0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.l10n.bannerTitle,
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: AppMeasurements.paddingMedium),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.white.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_forward_rounded,
                              color: AppColors.brandLight,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: -10,
                bottom: -20,
                child: Icon(
                  Icons.business_center_rounded,
                  size: 130,
                  color: AppColors.white.withValues(alpha: 0.15),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
