import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/application_stats_entity.dart';
import 'package:jobify_project/domain/entities/user_entity.dart';
import 'package:jobify_project/domain/use_cases/get_user_profile_use_case.dart';
import 'package:jobify_project/domain/use_cases/get_application_stats_use_case.dart';
import 'package:jobify_project/domain/use_cases/logout_use_case.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view_model/profile_event.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view_model/profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final GetUserProfileUseCase _getUserProfileUseCase;
  final GetApplicationStatsUseCase _getApplicationStatsUseCase;
  final LogoutUseCase _logoutUseCase;

  ProfileCubit(
    this._getUserProfileUseCase,
    this._getApplicationStatsUseCase,
    this._logoutUseCase,
  ) : super(const ProfileState()) {
    _init();
  }

  void _init() {
    _onLoadProfile();
  }

  void doIntent(ProfileEvent event) {
    switch (event) {
      case LoadProfileEvent():
        _onLoadProfile();
      case UpdateContactInfoProfileEvent():
        _onUpdateContactInfo(event);
      case LogoutProfileEvent():
        _onLogout();
    }
  }

  Future<void> _onLoadProfile() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    final result = await _getUserProfileUseCase();
    final statsResult = await _getApplicationStatsUseCase();

    switch (result) {
      case ApiSuccessResult<UserEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            data: result.data,
            stats: statsResult is ApiSuccessResult<ApplicationStatsEntity>
                ? statsResult.data
                : null,
          ),
        );
      case ApiErrorResult<UserEntity>():
        emit(state.copyWith(
            isLoading: false, errorMessage: result.errorMessage));
    }
  }

  void _onUpdateContactInfo(UpdateContactInfoProfileEvent event) {
    // Contact updates are handled via EditProfileScreen.
    // If local update is needed in the future, it can be implemented here.
  }

  Future<void> _onLogout() async {
    emit(state.copyWith(isLogoutLoading: true, clearError: true));
    final result = await _logoutUseCase();
    switch (result) {
      case ApiSuccessResult():
        emit(state.copyWith(isLogoutLoading: false, logoutSuccess: true));
      case ApiErrorResult():
        emit(
          state.copyWith(
            isLogoutLoading: false,
            errorMessage: result.errorMessage,
          ),
        );
    }
  }
}
