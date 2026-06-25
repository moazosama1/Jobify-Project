import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/my_job_application_entity.dart';
import 'package:jobify_project/domain/use_cases/get_my_applications_use_case.dart';
import 'package:jobify_project/presentation/job_seeker/applications/view_model/applications_events.dart';
import 'package:jobify_project/presentation/job_seeker/applications/view_model/applications_state.dart';

@injectable
class JobSeekerApplicationsCubit extends Cubit<JobSeekerApplicationsState> {
  final GetMyApplicationsUseCase _getMyApplicationsUseCase;

  JobSeekerApplicationsCubit(this._getMyApplicationsUseCase)
      : super(const JobSeekerApplicationsState(
          applicationsStatus: BaseState(),
          selectedFilter: null,
        )) {
    _init();
  }

  void _init() {
    doIntent(LoadMyApplicationsEvent());
  }

  void doIntent(JobSeekerApplicationsEvents event) {
    switch (event) {
      case LoadMyApplicationsEvent():
        _loadApplications(event);
      case ChangeApplicationsFilterEvent():
        _changeFilter(event);
      case SearchMyApplicationsEvent():
        _searchApplications(event);
    }
  }

  Future<void> _loadApplications(LoadMyApplicationsEvent event) async {
    emit(state.copyWith(
      applicationsStatus: BaseState(
        isLoading: true,
        data: state.applicationsStatus.data,
      ),
    ));

    final result = await _getMyApplicationsUseCase.call(status: event.status);

    switch (result) {
      case ApiSuccessResult():
        emit(
          state.copyWith(
            allApplications: result.data.applications,
          ),
        );
        _applyFiltersAndSearch();
      case ApiErrorResult():
        emit(
          state.copyWith(
            applicationsStatus: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  void _changeFilter(ChangeApplicationsFilterEvent event) {
    if (state.selectedFilter == event.status) return;

    emit(
      state.copyWith(
        selectedFilter: event.status,
        forceNullFilter: event.status == null,
      ),
    );
    doIntent(LoadMyApplicationsEvent(status: event.status));
  }

  void _searchApplications(SearchMyApplicationsEvent event) {
    emit(state.copyWith(searchQuery: event.query));
    _applyFiltersAndSearch();
  }

  void _applyFiltersAndSearch() {
    List<MyJobApplicationEntity> filtered = state.allApplications;

    if (state.searchQuery.trim().isNotEmpty) {
      final query = state.searchQuery.trim().toLowerCase();
      filtered =
          filtered.where((app) {
            final title = app.job?.title.toLowerCase() ?? '';
            final company = app.job?.companyName.toLowerCase() ?? '';
            return title.contains(query) || company.contains(query);
          }).toList();
    }

    emit(state.copyWith(applicationsStatus: BaseState.success(filtered)));
  }
}
