import 'package:flutter/material.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/domain/entities/category_entity.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:jobify_project/presentation/job_seeker/home/view/screens/widgets/category_item_widget.dart';

class CategorySectionWidget extends StatelessWidget {
  final List<CategoryEntity> categories;
  final AppLocalizations local;
  final double contentPadding;
  final Function(CategoryEntity)? onCategoryTap;

  const CategorySectionWidget({
    super.key,
    required this.categories,
    required this.local,
    this.contentPadding = AppMeasurements.paddingLarge,
    this.onCategoryTap,
  });

  static const _accentColors = <Color>[
    Color(0xFF3B7DFF), // Blue — Company
    Color(0xFF2ECC8F), // Teal Green — Full-time
    Color(0xFFF5A623), // Warm Amber — Part-time
    Color(0xFF8B5CF6), // Soft Violet — Freelance
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: contentPadding,
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
          height: 115,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(
              horizontal: contentPadding,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (context, index) =>
                const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final category = categories[index];
              final accentColor = _accentColors[index % _accentColors.length];

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
                imagePath: category.icon,
                label: label,
                accentColor: accentColor,
                onTap: () {
                  if (onCategoryTap != null) {
                    onCategoryTap!(category);
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

