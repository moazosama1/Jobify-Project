import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/user_entity.dart';
import 'package:jobify_project/domain/entities/application_stats_entity.dart';

class ProfileState extends BaseState<UserEntity> {
  final bool isLogoutLoading;
  final bool logoutSuccess;
  final ApplicationStatsEntity? stats;

  const ProfileState({
    super.isLoading = false,
    super.errorMessage,
    super.data,
    this.isLogoutLoading = false,
    this.logoutSuccess = false,
    this.stats,
  });

  ProfileState copyWith({
    bool? isLoading,
    String? errorMessage,
    UserEntity? data,
    bool? isLogoutLoading,
    bool? logoutSuccess,
    ApplicationStatsEntity? stats,
    bool clearError = false,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      data: data ?? this.data,
      isLogoutLoading: isLogoutLoading ?? this.isLogoutLoading,
      logoutSuccess: logoutSuccess ?? this.logoutSuccess,
      stats: stats ?? this.stats,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        data,
        isLogoutLoading,
        logoutSuccess,
        stats,
      ];
}
