import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/user_entity.dart';
import 'package:jobify_project/domain/use_cases/auth/get_user_profile_use_case.dart';
import 'package:jobify_project/domain/use_cases/auth/update_basic_info_use_case.dart';

import 'edit_profile_event.dart';
import 'edit_profile_state.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileState> {
  final GetUserProfileUseCase _getUserProfileUseCase;
  final UpdateBasicInfoUseCase _updateBasicInfoUseCase;

  EditProfileCubit(
    this._getUserProfileUseCase,
    this._updateBasicInfoUseCase,
  ) : super(const EditProfileState()) {
    _init();
  }

  void _init() {
    doIntent(LoadEditProfileEvent());
  }

  void doIntent(EditProfileEvent event) {
    switch (event) {
      case LoadEditProfileEvent():
        _onLoadEditProfileEvent();
        break;
      case UpdateBasicInfoEvent():
        _onUpdateBasicInfoEvent(event);
        break;
    }
  }

  Future<void> _onLoadEditProfileEvent() async {
    emit(state.copyWith(profileState:  BaseState.loading(), clearSuccess: true));
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

  Future<void> _onUpdateBasicInfoEvent(UpdateBasicInfoEvent event) async {
    emit(state.copyWith(profileState:  BaseState.loading(), clearSuccess: true));
    final result = await _updateBasicInfoUseCase(event.request);
    switch (result) {
      case ApiSuccessResult<UserEntity>():
        emit(
          state.copyWith(
            profileState: BaseState.success(result.data),
            successMessage: "Basic info updated successfully",
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
}
