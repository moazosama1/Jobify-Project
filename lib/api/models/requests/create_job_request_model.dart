import 'package:json_annotation/json_annotation.dart';
import 'package:jobify_project/api/models/requests/company_snapshot_model.dart';
import 'package:jobify_project/api/models/requests/salary_range_model.dart';

part 'create_job_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateJobRequestModel {
  final CompanySnapshotModel companySnapshot;
  final String title;
  final String description;
  final List<String> responsibilities;
  final List<String> requirements;
  final List<String> preferredQualifications;
  final String location;
  final String employmentType;
  final String experienceLevel;
  final SalaryRangeModel salaryRange;
  final String applicationDeadline;
  final List<String> skillsRequired;
  final String category;
  final int openings;
  final bool isRemote;

  CreateJobRequestModel({
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

  factory CreateJobRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CreateJobRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateJobRequestModelToJson(this);
}
