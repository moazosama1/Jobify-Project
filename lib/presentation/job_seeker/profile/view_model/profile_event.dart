sealed class ProfileEvent {
  const ProfileEvent();
}

class ProfileLoadDataEvent extends ProfileEvent {
  const ProfileLoadDataEvent();
}

class ProfileUpdateContactInfoEvent extends ProfileEvent {
  final String name;
  final String email;
  final String phoneNumber;

  const ProfileUpdateContactInfoEvent({
    required this.name,
    required this.email,
    required this.phoneNumber,
  });
}

class ProfileLogoutEvent extends ProfileEvent {
  const ProfileLogoutEvent();
}
