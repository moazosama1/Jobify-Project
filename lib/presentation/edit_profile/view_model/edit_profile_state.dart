import 'package:jobify_project/core/api_result/base_state.dart';

class EditProfileState extends BaseState<dynamic> {
  final String name;
  final String contactNumber;
  final String dateOfBirth;
  final String aboutYou;
  final String photoUrl;

  const EditProfileState({
    super.isLoading = false,
    super.errorMessage,
    this.name = '',
    this.contactNumber = '',
    this.dateOfBirth = '',
    this.aboutYou = '',
    this.photoUrl = '',
  });

  EditProfileState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? name,
    String? contactNumber,
    String? dateOfBirth,
    String? aboutYou,
    String? photoUrl,
    bool clearError = false,
  }) {
    return EditProfileState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      name: name ?? this.name,
      contactNumber: contactNumber ?? this.contactNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      aboutYou: aboutYou ?? this.aboutYou,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        name,
        contactNumber,
        dateOfBirth,
        aboutYou,
        photoUrl,
      ];
}
