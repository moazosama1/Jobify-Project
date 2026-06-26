sealed class EditProfileEvent {
  const EditProfileEvent();
}

class LoadEditProfileEvent extends EditProfileEvent {
  const LoadEditProfileEvent();
}

class SubmitEditProfileEvent extends EditProfileEvent {
  final String name;
  final String contactNumber;
  final String dateOfBirth;
  final String aboutYou;
  final String photoUrl;

  const SubmitEditProfileEvent({
    required this.name,
    required this.contactNumber,
    required this.dateOfBirth,
    required this.aboutYou,
    required this.photoUrl,
  });
}
