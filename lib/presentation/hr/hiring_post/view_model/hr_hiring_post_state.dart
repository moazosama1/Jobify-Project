import 'package:jobify_project/core/api_result/base_state.dart';

class HrHiringPostState extends BaseState<dynamic> {
  final String jobTitle;
  final String positionLevel;
  final String yearsOfExperience;
  final String location;
  final String education;
  final String jobRequirements;

  const HrHiringPostState({
    super.isLoading = false,
    super.errorMessage,
    this.jobTitle = '',
    this.positionLevel = '',
    this.yearsOfExperience = '',
    this.location = '',
    this.education = '',
    this.jobRequirements = '',
  });

  HrHiringPostState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? jobTitle,
    String? positionLevel,
    String? yearsOfExperience,
    String? location,
    String? education,
    String? jobRequirements,
    bool clearError = false,
  }) {
    return HrHiringPostState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      jobTitle: jobTitle ?? this.jobTitle,
      positionLevel: positionLevel ?? this.positionLevel,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      location: location ?? this.location,
      education: education ?? this.education,
      jobRequirements: jobRequirements ?? this.jobRequirements,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        jobTitle,
        positionLevel,
        yearsOfExperience,
        location,
        education,
        jobRequirements,
      ];
}
