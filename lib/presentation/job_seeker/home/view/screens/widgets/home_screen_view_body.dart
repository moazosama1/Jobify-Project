import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/router/route_names.dart';
import 'package:jobify_project/core/widgets/custom_loading_indicator.dart';
import 'package:jobify_project/core/widgets/custom_user_info_app_bar.dart';
import 'package:jobify_project/presentation/job_seeker/home/view/screens/widgets/category_section_widget.dart';
import 'package:jobify_project/presentation/job_seeker/home/view/screens/widgets/recent_jobs_section_widget.dart';
import 'package:jobify_project/presentation/job_seeker/home/view/screens/widgets/search_section_widget.dart';
import 'package:jobify_project/presentation/job_seeker/home/view/screens/widgets/suggested_jobs_section_widget.dart';
import 'package:jobify_project/presentation/job_seeker/home/view_model/home_cubit.dart';
import 'package:jobify_project/presentation/job_seeker/home/view_model/home_event.dart';
import 'package:jobify_project/presentation/job_seeker/home/view_model/home_state.dart';
import 'package:jobify_project/domain/entities/requests/get_all_jobs_request_entity.dart';
import 'package:jobify_project/generated/l10n.dart';

class HomeScreenViewBody extends StatelessWidget {
  const HomeScreenViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.isLoading && state.categories.isEmpty) {
          return const Center(child: CustomLoadingIndicator());
        }

        if (state.errorMessage != null && state.categories.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(AppMeasurements.paddingLarge),
              child: Text(
                state.errorMessage!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.error,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            context.read<HomeCubit>().doIntent(HomeLoadDataEvent());
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppMeasurements.paddingSmall),
                CustomUserInfoAppBar(
                  welcomeText: local.welcomeUser,
                  userNameText: local.helloUser,
                  onSavedPressed: () {
                    context.push(RouteNames.savedJobs);
                  },
                ),
                const SizedBox(height: AppMeasurements.paddingLarge),
                SearchSectionWidget(
                  hintText: local.searchPlaceholder,
                  hasActiveFilters: false,
                  onFilterPressed: () {
                    context.push(RouteNames.search);
                  },
                ),
                const SizedBox(height: AppMeasurements.paddingLarge),
                CategorySectionWidget(
                  categories: state.categories,
                  local: local,
                  onCategoryTap: (category) {
                    var categoryFilter = '';
                    var employmentTypeFilter = '';

                    if (category.nameKey == 'categoryCompany') categoryFilter = 'Company';
                    else if (category.nameKey == 'categoryFullTime') employmentTypeFilter = 'full_time';
                    else if (category.nameKey == 'categoryPartTime') employmentTypeFilter = 'part_time';
                    else if (category.nameKey == 'categoryFreelance') categoryFilter = 'Freelance';
                    else categoryFilter = category.nameKey;

                    final filters = GetAllJobsRequestEntity(
                      category: categoryFilter.isNotEmpty ? categoryFilter : null,
                      employmentType: employmentTypeFilter.isNotEmpty ? employmentTypeFilter : null,
                    );
                    context.push(RouteNames.search, extra: filters);
                  },
                ),
                const SizedBox(height: AppMeasurements.paddingLarge),
                SuggestedJobsSectionWidget(
                  suggestedJobs: state.suggestedJobs,
                  local: local,
                  onSeeAllPressed: () {},
                ),
                const SizedBox(height: AppMeasurements.paddingLarge),
                RecentJobsSectionWidget(
                  recentJobs: state.recentJobs,
                  local: local,
                  onSeeAllPressed: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
