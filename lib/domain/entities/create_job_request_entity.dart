import 'package:equatable/equatable.dart';
import 'company_snapshot_entity.dart';
import 'salary_range_entity.dart';

class CreateJobRequestEntity extends Equatable {
  final CompanySnapshotEntity companySnapshot;
  final String title;
  final String description;
  final List<String> responsibilities;
  final List<String> requirements;
  final List<String> preferredQualifications;
  final String location;
  final String employmentType;
  final String experienceLevel;
  final SalaryRangeEntity salaryRange;
  final String applicationDeadline;
  final List<String> skillsRequired;
  final String category;
  final int openings;
  final bool isRemote;

  const CreateJobRequestEntity({
    required this.companySnapshot,
    required this.title,
    required this.description,
    required this.responsibilities,
    required this.requirements,
    required this.preferredQualifications,
    required this.location,
    required this.employmentType,
    required this.experienceLevel,
    required this.salaryRange,
    required this.applicationDeadline,
    required this.skillsRequired,
    required this.category,
    required this.openings,
    required this.isRemote,
  });

  @override
  List<Object?> get props => [
        companySnapshot,
        title,
        description,
        responsibilities,
        requirements,
        preferredQualifications,
        location,
        employmentType,
        experienceLevel,
        salaryRange,
        applicationDeadline,
        skillsRequired,
        category,
        openings,
        isRemote,
      ];
}
