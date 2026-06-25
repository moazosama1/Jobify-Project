sealed class ProfileEvent {
  const ProfileEvent();
}

class LoadProfileEvent extends ProfileEvent {
  const LoadProfileEvent();
}

class UpdateContactInfoProfileEvent extends ProfileEvent {
  final String name;
  final String email;
  final String phoneNumber;

  const UpdateContactInfoProfileEvent({
    required this.name,
    required this.email,
    required this.phoneNumber,
  });
}

class LogoutProfileEvent extends ProfileEvent {
  const LogoutProfileEvent();
}
