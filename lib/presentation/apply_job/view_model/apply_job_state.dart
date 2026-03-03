import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:jobify_project/core/api_result/base_state.dart';

class ApplyJobState extends Equatable {
  final String fullName;
  final String portfolioUrl;
  final String motivationalLetter;
  final PlatformFile? selectedCv;
  final BaseState<bool> apiStatus;

  const ApplyJobState({
    this.fullName = '',
    this.portfolioUrl = '',
    this.motivationalLetter = '',
    this.selectedCv,
    this.apiStatus = const BaseState<bool>(),
  });

  ApplyJobState copyWith({
    String? fullName,
    String? portfolioUrl,
    String? motivationalLetter,
    PlatformFile? selectedCv,
    BaseState<bool>? apiStatus,
  }) {
    return ApplyJobState(
      fullName: fullName ?? this.fullName,
      portfolioUrl: portfolioUrl ?? this.portfolioUrl,
      motivationalLetter: motivationalLetter ?? this.motivationalLetter,
      selectedCv: selectedCv ?? this.selectedCv,
      apiStatus: apiStatus ?? this.apiStatus,
    );
  }

  @override
  List<Object?> get props => [
    fullName,
    portfolioUrl,
    motivationalLetter,
    selectedCv,
    apiStatus,
  ];
}
