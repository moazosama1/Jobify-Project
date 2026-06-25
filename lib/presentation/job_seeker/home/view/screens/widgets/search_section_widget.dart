import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppMeasurements.paddingMedium,
      ),
      child: InkWell(
        onTap: () {
          context.push(RouteNames.search);
        },
        child: Container(
          width: double.infinity,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.lightGray.withValues(alpha: 0.5),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            border: Border.all(color: AppColors.gray.withValues(alpha: 0.5)),
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
                  style: context.bodyMedium?.copyWith(
                    color: AppColors.gray.withValues(alpha: 0.4),
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(AppMeasurements.paddingSmall),
                  child: InkWell(
                    onTap: onFilterPressed,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: hasActiveFilters
                            ? context.primaryColor
                            : context.primaryColor.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.tune_rounded,
                        color: hasActiveFilters
                            ? context.onPrimaryColor
                            : context.primaryColor,
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
    );
  }
}
