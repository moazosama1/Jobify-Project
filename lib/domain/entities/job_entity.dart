import 'package:equatable/equatable.dart';

class JobEntity extends Equatable {
  final String id;
  final String companyName;
  final String logoAsset;
  final String title;
  final String salary;
  final List<String> tags;
  final String location;
  final bool isBookmarked;
  
  // Enriched fields for full detail / editing
  final String description;
  final List<String> responsibilities;
  final List<String> requirements;
  final List<String> preferredQualifications;
  final String employmentType;
  final String experienceLevel;
  final int salaryMin;
  final int salaryMax;
  final String applicationDeadline;
  final List<String> skillsRequired;
  final String category;
  final int openings;
  final bool isRemote;

  const JobEntity({
    required this.id,
    required this.companyName,
    required this.logoAsset,
    required this.title,
    required this.salary,
    required this.tags,
    required this.location,
    this.isBookmarked = false,
    this.description = '',
    this.responsibilities = const [],
    this.requirements = const [],
    this.preferredQualifications = const [],
    this.employmentType = '',
    this.experienceLevel = '',
    this.salaryMin = 0,
    this.salaryMax = 0,
    this.applicationDeadline = '',
    this.skillsRequired = const [],
    this.category = '',
    this.openings = 1,
    this.isRemote = false,
  });

  JobEntity copyWith({
    String? id,
    String? companyName,
    String? logoAsset,
    String? title,
    String? salary,
    List<String>? tags,
    String? location,
    bool? isBookmarked,
    String? description,
    List<String>? responsibilities,
    List<String>? requirements,
    List<String>? preferredQualifications,
    String? employmentType,
    String? experienceLevel,
    int? salaryMin,
    int? salaryMax,
    String? applicationDeadline,
    List<String>? skillsRequired,
    String? category,
    int? openings,
    bool? isRemote,
  }) {
    return JobEntity(
      id: id ?? this.id,
      companyName: companyName ?? this.companyName,
      logoAsset: logoAsset ?? this.logoAsset,
      title: title ?? this.title,
      salary: salary ?? this.salary,
      tags: tags ?? this.tags,
      location: location ?? this.location,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      description: description ?? this.description,
      responsibilities: responsibilities ?? this.responsibilities,
      requirements: requirements ?? this.requirements,
      preferredQualifications: preferredQualifications ?? this.preferredQualifications,
      employmentType: employmentType ?? this.employmentType,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      salaryMin: salaryMin ?? this.salaryMin,
      salaryMax: salaryMax ?? this.salaryMax,
      applicationDeadline: applicationDeadline ?? this.applicationDeadline,
      skillsRequired: skillsRequired ?? this.skillsRequired,
      category: category ?? this.category,
      openings: openings ?? this.openings,
      isRemote: isRemote ?? this.isRemote,
    );
  }

  @override
  List<Object?> get props => [
        id,
        companyName,
        logoAsset,
        title,
        salary,
        tags,
        location,
        isBookmarked,
        description,
        responsibilities,
        requirements,
        preferredQualifications,
        employmentType,
        experienceLevel,
        salaryMin,
        salaryMax,
        applicationDeadline,
        skillsRequired,
        category,
        openings,
        isRemote,
      ];
}
