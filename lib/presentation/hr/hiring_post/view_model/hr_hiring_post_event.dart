import 'package:jobify_project/domain/entities/job_entity.dart';

sealed class HrHiringPostEvent {
  const HrHiringPostEvent();
}

class HrHiringPostSubmitEvent extends HrHiringPostEvent {
  final String companyName;
  final String companyLogo;
  final String title;
  final String description;
  final String responsibilities;
  final String requirements;
  final String preferredQualifications;
  final String location;
  final String employmentType;
  final String experienceLevel;
  final int salaryMin;
  final int salaryMax;
  final String applicationDeadline;
  final String skillsRequired;
  final String category;
  final int openings;
  final bool isRemote;

  const HrHiringPostSubmitEvent({
    required this.companyName,
    required this.companyLogo,
    required this.title,
    required this.description,
    required this.responsibilities,
    required this.requirements,
    required this.preferredQualifications,
    required this.location,
    required this.employmentType,
    required this.experienceLevel,
    required this.salaryMin,
    required this.salaryMax,
    required this.applicationDeadline,
    required this.skillsRequired,
    required this.category,
    required this.openings,
    required this.isRemote,
  });
}

class HrHiringPostUpdateEvent extends HrHiringPostEvent {
  final String jobId;
  final JobEntity originalJob;
  final String companyName;
  final String companyLogo;
  final String title;
  final String description;
  final String responsibilities;
  final String requirements;
  final String preferredQualifications;
  final String location;
  final String employmentType;
  final String experienceLevel;
  final int salaryMin;
  final int salaryMax;
  final String applicationDeadline;
  final String skillsRequired;
  final String category;
  final int openings;
  final bool isRemote;

  const HrHiringPostUpdateEvent({
    required this.jobId,
    required this.originalJob,
    required this.companyName,
    required this.companyLogo,
    required this.title,
    required this.description,
    required this.responsibilities,
    required this.requirements,
    required this.preferredQualifications,
    required this.location,
    required this.employmentType,
    required this.experienceLevel,
    required this.salaryMin,
    required this.salaryMax,
    required this.applicationDeadline,
    required this.skillsRequired,
    required this.category,
    required this.openings,
    required this.isRemote,
  });
}
