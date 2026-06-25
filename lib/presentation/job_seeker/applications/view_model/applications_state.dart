import 'package:equatable/equatable.dart';
import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/my_job_application_entity.dart';

class JobSeekerApplicationsState extends Equatable {
  final BaseState<List<MyJobApplicationEntity>> applicationsStatus;
  final String? selectedFilter; // null for 'All', 'pending', 'accepted', 'rejected'
  final List<MyJobApplicationEntity> allApplications;
  final String searchQuery;

  const JobSeekerApplicationsState({
    required this.applicationsStatus,
    this.selectedFilter,
    this.allApplications = const [],
    this.searchQuery = '',
  });

  JobSeekerApplicationsState copyWith({
    BaseState<List<MyJobApplicationEntity>>? applicationsStatus,
    String? selectedFilter,
    bool forceNullFilter = false,
    List<MyJobApplicationEntity>? allApplications,
    String? searchQuery,
  }) {
    return JobSeekerApplicationsState(
      applicationsStatus: applicationsStatus ?? this.applicationsStatus,
      selectedFilter: forceNullFilter ? null : (selectedFilter ?? this.selectedFilter),
      allApplications: allApplications ?? this.allApplications,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [applicationsStatus, selectedFilter, allApplications, searchQuery];
}
