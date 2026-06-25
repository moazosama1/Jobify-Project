import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/widgets/custom_app_bar.dart';
import 'package:jobify_project/core/widgets/custom_application_card.dart';
import 'package:jobify_project/core/widgets/custom_search_bar.dart';
import 'package:jobify_project/presentation/job_seeker/applications/view_model/applications_cubit.dart';
import 'package:jobify_project/presentation/job_seeker/applications/view_model/applications_events.dart';
import 'package:jobify_project/presentation/job_seeker/applications/view_model/applications_state.dart';

class ApplicationsViewBody extends StatelessWidget {
  const ApplicationsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(title: context.l10n.myApplications, showBackButton: false),
        CustomSearchBar(
          hintText: context.l10n.searchApplication,
          onChanged: (value) {
            context.read<JobSeekerApplicationsCubit>().doIntent(
              SearchMyApplicationsEvent(query: value),
            );
          },
        ),
        const SizedBox(height: AppMeasurements.paddingMedium),
        _buildFilters(context),
        const SizedBox(height: AppMeasurements.paddingMedium),
        Expanded(
          child:
              BlocBuilder<
                JobSeekerApplicationsCubit,
                JobSeekerApplicationsState
              >(
                builder: (context, state) {
                  final status = state.applicationsStatus;
                  final apps = status.data ?? [];

                  if (status.isLoading && apps.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (status.errorMessage != null && apps.isEmpty) {
                    return Center(child: Text(status.errorMessage!));
                  }

                  if (apps.isEmpty) {
                    return Center(
                      child: Text(context.l10n.noApplicationsFound),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<JobSeekerApplicationsCubit>().doIntent(
                        LoadMyApplicationsEvent(status: state.selectedFilter),
                      );
                      await Future.delayed(const Duration(milliseconds: 500));
                    },
                    child: ListView.separated(
                      itemCount: apps.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: AppMeasurements.paddingMedium),
                      itemBuilder: (context, index) {
                        final application = apps[index];
                        final job = application.job;

                        // Convert backend status to enum
                        ApplicationStatus appStatus;
                        switch (application.status.toLowerCase()) {
                          case 'accepted':
                            appStatus = ApplicationStatus.onTheWay;
                          case 'rejected':
                            appStatus = ApplicationStatus.canceled;
                          default:
                            appStatus = ApplicationStatus.delivered;
                        }

                        return SizedBox(
                          width: double.infinity,
                          child: CustomJobApplicationCard(
                            jobTitle: job?.title ?? 'Unknown Job',
                            companyName: job?.companyName ?? 'Unknown Company',
                            salary: job?.salary ?? 'N/A',
                            location: job?.location ?? 'N/A',
                            logoUrl: job?.logoAsset ?? '',
                            employmentType: job?.employmentType ?? '',
                            createdAt: application.createdAt,
                            status: appStatus,
                            onViewApplication: () {},
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
        ),
      ],
    );
  }

  Widget _buildFilters(BuildContext context) {
    return BlocBuilder<JobSeekerApplicationsCubit, JobSeekerApplicationsState>(
      buildWhen: (previous, current) =>
          previous.selectedFilter != current.selectedFilter,
      builder: (context, state) {
        final filters = [
          (null, context.l10n.all),
          ('pending', context.l10n.pending),
          ('accepted', context.l10n.accepted),
          ('rejected', context.l10n.rejected),
        ];

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: filters.map((filter) {
              final isSelected = state.selectedFilter == filter.$1;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: FilterChip(
                  label: Text(
                    filter.$2,
                    style: context.bodySmall?.copyWith(
                      color: isSelected
                          ? context.onPrimaryColor
                          : context.onSurfaceColor,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      context.read<JobSeekerApplicationsCubit>().doIntent(
                        ChangeApplicationsFilterEvent(status: filter.$1),
                      );
                    }
                  },
                  backgroundColor: context.surfaceColor,
                  selectedColor: context.primaryColor,
                  checkmarkColor: context.onPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: isSelected
                          ? Colors.transparent
                          : context.onSurfaceColor.withValues(alpha: 0.2),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
