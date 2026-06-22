sealed class EditProfileEvent {
  const EditProfileEvent();
}

class EditProfileLoadEvent extends EditProfileEvent {
  const EditProfileLoadEvent();
}

class EditProfileSubmitEvent extends EditProfileEvent {
  final String name;
  final String contactNumber;
  final String dateOfBirth;
  final String aboutYou;
  final String photoUrl;

  const EditProfileSubmitEvent({
    required this.name,
    required this.contactNumber,
    required this.dateOfBirth,
    required this.aboutYou,
    required this.photoUrl,
  });
}
