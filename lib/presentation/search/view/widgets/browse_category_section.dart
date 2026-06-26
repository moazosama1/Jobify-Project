import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/constants/app_images.dart';
import 'package:jobify_project/domain/entities/category_entity.dart';
import 'package:jobify_project/domain/entities/requests/get_all_jobs_request_entity.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:jobify_project/presentation/job_seeker/home/view/screens/widgets/category_section_widget.dart';
import 'package:jobify_project/presentation/search/view_model/search_cubit.dart';
import 'package:jobify_project/presentation/search/view_model/search_event.dart';

class BrowseCategorySection extends StatelessWidget {
  const BrowseCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    final mockCategories = [
      const CategoryEntity(
        id: '1',
        nameKey: 'categoryCompany',
        icon: AppImages.iconCompany,
      ),
      const CategoryEntity(
        id: '2',
        nameKey: 'categoryFullTime',
        icon: AppImages.iconFullTime,
      ),
      const CategoryEntity(
        id: '3',
        nameKey: 'categoryPartTime',
        icon: AppImages.iconPartTime,
      ),
      const CategoryEntity(
        id: '4',
        nameKey: 'categoryFreelance',
        icon: AppImages.iconFreelance,
      ),
    ];

    return CategorySectionWidget(
      categories: mockCategories,
      local: local,
      contentPadding: 0,
      onCategoryTap: (category) {
        var categoryFilter = '';
        var employmentTypeFilter = '';

        if (category.nameKey == 'categoryCompany')
          categoryFilter = 'Company';
        else if (category.nameKey == 'categoryFullTime')
          employmentTypeFilter = 'full_time';
        else if (category.nameKey == 'categoryPartTime')
          employmentTypeFilter = 'part_time';
        else if (category.nameKey == 'categoryFreelance')
          categoryFilter = 'Freelance';
        else
          categoryFilter = category.nameKey;

        context.read<SearchCubit>().doIntent(
          UpdateFiltersSearchEvent(
            GetAllJobsRequestEntity(
              category: categoryFilter.isNotEmpty ? categoryFilter : null,
              employmentType: employmentTypeFilter.isNotEmpty
                  ? employmentTypeFilter
                  : null,
            ),
          ),
        );
      },
    );
  }
}
