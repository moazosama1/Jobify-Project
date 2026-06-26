import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/user_entity.dart';
import 'package:jobify_project/domain/use_cases/auth/get_user_profile_use_case.dart';
import 'package:jobify_project/domain/use_cases/logout_use_case.dart';
import 'hr_profile_event.dart';
import 'hr_profile_state.dart';

@injectable
class HrProfileCubit extends Cubit<HrProfileState> {
  final GetUserProfileUseCase _getUserProfileUseCase;
  final LogoutUseCase _logoutUseCase;

  HrProfileCubit(
    this._getUserProfileUseCase,
    this._logoutUseCase,
  ) : super(const HrProfileState()) {
    _init();
  }

  void _init() {
    _onLoadData();
  }

  void doIntent(HrProfileEvent event) {
    switch (event) {
      case LoadHrProfileEvent():
        _onLoadData();
      case LogoutHrProfileEvent():
        _onLogout();
    }
  }

  Future<void> _onLoadData() async {
    emit(state.copyWith(profileState:  BaseState.loading()));
    final result = await _getUserProfileUseCase();
    switch (result) {
      case ApiSuccessResult<UserEntity>():
        emit(
          state.copyWith(
            profileState: BaseState.success(result.data),
          ),
        );
      case ApiErrorResult<UserEntity>():
        emit(
          state.copyWith(
            profileState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  Future<void> _onLogout() async {
    emit(state.copyWith(isLogoutLoading: true));
    final result = await _logoutUseCase();
    switch (result) {
      case ApiSuccessResult():
        emit(state.copyWith(isLogoutLoading: false, logoutSuccess: true));
      case ApiErrorResult():
        emit(
          state.copyWith(
            isLogoutLoading: false,
            profileState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }
}
