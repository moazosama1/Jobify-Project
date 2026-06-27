import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/router/route_names.dart';
import 'package:jobify_project/core/widgets/custom_loading_indicator.dart';
import 'package:jobify_project/core/widgets/custom_user_info_app_bar.dart';
import 'hr_recent_jobs_section_widget.dart';
import 'hr_search_section_widget.dart';
import '../../../view_model/hr_home_cubit.dart';
import '../../../view_model/hr_home_event.dart';
import '../../../view_model/hr_home_state.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:jobify_project/core/cubit/core_cubit.dart';
import 'package:jobify_project/core/constants/end_points.dart';

class HrHomeScreenViewBody extends StatelessWidget {
  const HrHomeScreenViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context);

    final coreState = context.watch<CoreCubit>().state;
    final userName = (coreState is CoreStateChanged && coreState.user != null)
        ? '${coreState.user!.firstName} ${coreState.user!.lastName}'
        : local.helloUser;

    return BlocBuilder<HrHomeCubit, HrHomeState>(
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
            // context.read<HrHomeCubit>().doIntent(HrHomeLoadDataEvent());
            context.read<CoreCubit>().fetchUserInfo();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppMeasurements.paddingSmall),
                CustomUserInfoAppBar(
                  welcomeText: local.welcomeUser,
                  userNameText: userName,
                  profileImageUrl: (coreState is CoreStateChanged && coreState.user != null && coreState.user!.profileImage != null && coreState.user!.profileImage!.isNotEmpty)
                      ? "${EndPoints.awsBaseUrl}${coreState.user!.profileImage}"
                      : null,
                  onSavedPressed: () {
                    context.push(RouteNames.aiChat);
                  },
                  onProfilePressed: () {
                    context.push(RouteNames.hrProfile);
                  },
                ),
                const SizedBox(height: AppMeasurements.paddingLarge),

                HrSearchSectionWidget(
                  hintText: local.searchPlaceholder,
                  onFilterPressed: () {
                    // Handle filter button press.
                  },
                ),

                const SizedBox(height: AppMeasurements.paddingLarge),
                HrRecentJobsSectionWidget(
                  recentJobs: state.filteredRecentJobs,
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
