import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/user_entity.dart';
import 'package:jobify_project/domain/use_cases/get_profile_by_id_use_case.dart';
import 'user_profile_event.dart';
import 'user_profile_state.dart';

@injectable
class UserProfileCubit extends Cubit<UserProfileState> {
  final GetProfileByIdUseCase _getProfileByIdUseCase;

  UserProfileCubit(this._getProfileByIdUseCase)
      : super(const UserProfileState());

  void doIntent(UserProfileEvent event) {
    switch (event) {
      case LoadUserProfileEvent():
        _onLoadUserProfile(event.userId);
        break;
    }
  }

  Future<void> _onLoadUserProfile(String userId) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    final result = await _getProfileByIdUseCase(userId);
    switch (result) {
      case ApiSuccessResult<UserEntity>():
        emit(state.copyWith(isLoading: false, data: result.data));
        break;
      case ApiErrorResult<UserEntity>():
        emit(state.copyWith(isLoading: false, errorMessage: result.errorMessage));
        break;
    }
  }
}
