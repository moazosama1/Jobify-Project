sealed class HrHiringPostEvent {
  const HrHiringPostEvent();
}

class HrHiringPostSubmitEvent extends HrHiringPostEvent {
  final String jobTitle;
  final String positionLevel;
  final String yearsOfExperience;
  final String location;
  final String education;
  final String jobRequirements;

  const HrHiringPostSubmitEvent({
    required this.jobTitle,
    required this.positionLevel,
    required this.yearsOfExperience,
    required this.location,
    required this.education,
    required this.jobRequirements,
  });
}
