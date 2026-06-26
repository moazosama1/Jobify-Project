sealed class HrProfileEvent {
  const HrProfileEvent();
}

class LoadHrProfileEvent extends HrProfileEvent {
  const LoadHrProfileEvent();
}

class UpdateContactInfoHrProfileEvent extends HrProfileEvent {
  final String name;
  final String email;
  final String phoneNumber;

  const UpdateContactInfoHrProfileEvent({
    required this.name,
    required this.email,
    required this.phoneNumber,
  });
}

class LogoutHrProfileEvent extends HrProfileEvent {
  const LogoutHrProfileEvent();
}
