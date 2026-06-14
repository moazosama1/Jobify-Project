sealed class HrProfileEvent {
  const HrProfileEvent();
}

class HrProfileLoadDataEvent extends HrProfileEvent {
  const HrProfileLoadDataEvent();
}

class HrProfileUpdateContactInfoEvent extends HrProfileEvent {
  final String name;
  final String email;
  final String phoneNumber;

  const HrProfileUpdateContactInfoEvent({
    required this.name,
    required this.email,
    required this.phoneNumber,
  });
}
