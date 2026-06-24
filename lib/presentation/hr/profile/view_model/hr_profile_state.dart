import 'package:jobify_project/core/api_result/base_state.dart';

class HrProfileState extends BaseState<dynamic> {
  final String name;
  final String email;
  final String phoneNumber;
  final String title;
  final String description;
  final int appliedCount;
  final int reviewedCount;
  final int interviewCount;
  final bool isLogoutLoading;
  final bool logoutSuccess;

  const HrProfileState({
    super.isLoading = false,
    super.errorMessage,
    this.name = '',
    this.email = '',
    this.phoneNumber = '',
    this.title = '',
    this.description = '',
    this.appliedCount = 0,
    this.reviewedCount = 0,
    this.interviewCount = 0,
    this.isLogoutLoading = false,
    this.logoutSuccess = false,
  });

  HrProfileState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? name,
    String? email,
    String? phoneNumber,
    String? title,
    String? description,
    int? appliedCount,
    int? reviewedCount,
    int? interviewCount,
    bool? isLogoutLoading,
    bool? logoutSuccess,
    bool clearError = false,
  }) {
    return HrProfileState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      title: title ?? this.title,
      description: description ?? this.description,
      appliedCount: appliedCount ?? this.appliedCount,
      reviewedCount: reviewedCount ?? this.reviewedCount,
      interviewCount: interviewCount ?? this.interviewCount,
      isLogoutLoading: isLogoutLoading ?? this.isLogoutLoading,
      logoutSuccess: logoutSuccess ?? this.logoutSuccess,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        name,
        email,
        phoneNumber,
        title,
        description,
        appliedCount,
        reviewedCount,
        interviewCount,
        isLogoutLoading,
        logoutSuccess,
      ];
}
