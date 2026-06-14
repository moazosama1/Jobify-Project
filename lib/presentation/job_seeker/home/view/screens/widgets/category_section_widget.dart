import 'package:flutter/material.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/domain/entities/category_entity.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:jobify_project/presentation/job_seeker/home/view/screens/widgets/category_item_widget.dart';

class CategorySectionWidget extends StatelessWidget {
  final List<CategoryEntity> categories;
  final AppLocalizations local;

  const CategorySectionWidget({
    super.key,
    required this.categories,
    required this.local,
  });

  static const _iconColors = <Color>[
    Color(0xFF5C6BC0),
    Color(0xFF26A69A),
    Color(0xFFAB47BC),
    Color(0xFF29B6F6),
  ];

  static final _borderColors = <Color>[
    const Color(0xFF5C6BC0).withOpacity(0.15),
    const Color(0xFF26A69A).withOpacity(0.15),
    const Color(0xFFAB47BC).withOpacity(0.15),
    const Color(0xFF29B6F6).withOpacity(0.15),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppMeasurements.paddingLarge,
          ),
          child: Text(
            local.browseByCategory,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: AppMeasurements.paddingMedium),
        SizedBox(
          height: 100,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: AppMeasurements.paddingLarge,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (context, index) =>
                const SizedBox(width: AppMeasurements.paddingLarge),
            itemBuilder: (context, index) {
              final category = categories[index];
              final iconColor = _iconColors[index % _iconColors.length];
              final borderColor = _borderColors[index % _borderColors.length];

              var label = category.nameKey;
              if (category.nameKey == 'categoryCompany') {
                label = local.categoryCompany;
              } else if (category.nameKey == 'categoryFullTime') {
                label = local.categoryFullTime;
              } else if (category.nameKey == 'categoryPartTime') {
                label = local.categoryPartTime;
              } else if (category.nameKey == 'categoryFreelance') {
                label = local.categoryFreelance;
              }

              return CategoryItemWidget(
                icon: category.icon,
                label: label,
                iconColor: iconColor,
                borderColor: borderColor,
                onTap: () {
                  // Filter categories or navigate.
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
