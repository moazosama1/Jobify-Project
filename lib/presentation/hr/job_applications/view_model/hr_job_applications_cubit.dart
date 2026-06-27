import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/core/enums/application_status.dart';
import 'package:jobify_project/domain/entities/job_application_entity.dart';
import 'package:jobify_project/domain/entities/application_user_entity.dart';
import 'package:jobify_project/domain/use_cases/get_job_applications_use_case.dart';
import 'package:jobify_project/domain/use_cases/get_all_applications_use_case.dart';
import 'package:jobify_project/domain/use_cases/update_application_status_use_case.dart';
import 'package:jobify_project/domain/use_cases/get_profile_by_id_use_case.dart';
import 'hr_job_applications_event.dart';
import 'hr_job_applications_state.dart';

@injectable
class HrJobApplicationsCubit extends Cubit<HrJobApplicationsState> {
  final GetJobApplicationsUseCase _getJobApplicationsUseCase;
  final GetAllApplicationsUseCase _getAllApplicationsUseCase;
  final UpdateApplicationStatusUseCase _updateApplicationStatusUseCase;
  final GetProfileByIdUseCase _getProfileByIdUseCase;

  HrJobApplicationsCubit(
    this._getJobApplicationsUseCase,
    this._getAllApplicationsUseCase,
    this._updateApplicationStatusUseCase,
    this._getProfileByIdUseCase,
  ) : super(const HrJobApplicationsState());

  void doIntent(HrJobApplicationsEvent event) {
    switch (event) {
      case final LoadHrJobApplicationsEvent loadEvent:
        _onLoadApplications(loadEvent.jobId);
        break;
      case final UpdateStatusHrJobApplicationsEvent updateEvent:
        _onUpdateStatus(updateEvent.id, updateEvent.status);
        break;
    }
  }

  Future<void> _onLoadApplications(String jobId) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    final result = jobId.isEmpty
        ? await _getAllApplicationsUseCase()
        : await _getJobApplicationsUseCase(jobId);
    switch (result) {
      case ApiSuccessResult(:final data):
        if (jobId.isEmpty) {
          final updatedApps = await Future.wait(data.map((app) async {
            if (app.user.id.isNotEmpty) {
              final profileResult = await _getProfileByIdUseCase(app.user.id);
              switch (profileResult) {
                case ApiSuccessResult(:final data):
                  final userProfile = data;
                  return app.copyWith(
                    user: ApplicationUserEntity(
                      id: userProfile.id,
                      firstName: userProfile.firstName,
                      lastName: userProfile.lastName,
                      email: userProfile.email,
                      profileImage: userProfile.profileImage,
                    ),
                  );
                case ApiErrorResult():
                  break;
              }
            }
            return app;
          }));
          emit(state.copyWith(
            isLoading: false,
            applications: updatedApps,
          ));
        } else {
          emit(state.copyWith(
            isLoading: false,
            applications: data,
          ));
        }
        break;
      case ApiErrorResult(:final error):
        emit(state.copyWith(
          isLoading: false,
          errorMessage: error.toString(),
        ));
        break;
    }
  }

  Future<void> _onUpdateStatus(String id, ApplicationStatus status) async {
    final currentApplications = List<JobApplicationEntity>.from(state.applications);
    emit(state.copyWith(isLoading: true, clearError: true));
    final result = await _updateApplicationStatusUseCase(id, status);
    switch (result) {
      case ApiSuccessResult():
        final updatedList = currentApplications.map((app) {
          if (app.id == id) {
            return app.copyWith(status: status.name);
          }
          return app;
        }).toList();
        emit(state.copyWith(
          isLoading: false,
          applications: updatedList,
        ));
        break;
      case ApiErrorResult(:final error):
        emit(state.copyWith(
          isLoading: false,
          errorMessage: error.toString(),
        ));
        break;
    }
  }
}
