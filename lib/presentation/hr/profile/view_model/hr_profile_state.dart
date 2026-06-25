import 'package:equatable/equatable.dart';
import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/user_entity.dart';

class HrProfileState extends Equatable {
  final BaseState<UserEntity> profileState;
  final bool isLogoutLoading;
  final bool logoutSuccess;

  const HrProfileState({
    this.profileState = const BaseState<UserEntity>(),
    this.isLogoutLoading = false,
    this.logoutSuccess = false,
  });

  HrProfileState copyWith({
    BaseState<UserEntity>? profileState,
    bool? isLogoutLoading,
    bool? logoutSuccess,
  }) {
    return HrProfileState(
      profileState: profileState ?? this.profileState,
      isLogoutLoading: isLogoutLoading ?? this.isLogoutLoading,
      logoutSuccess: logoutSuccess ?? this.logoutSuccess,
    );
  }

  @override
  List<Object?> get props => [
        profileState,
        isLogoutLoading,
        logoutSuccess,
      ];
}
