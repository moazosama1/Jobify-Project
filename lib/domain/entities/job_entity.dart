import 'package:equatable/equatable.dart';

class JobEntity extends Equatable {
  final String id;
  final String companyName;
  final String logoAsset;
  final String title;
  final String salary;
  final List<String> tags;
  final String location;
  final String description;
  final List<String> responsibilities;
  final List<String> requirements;
  final List<String> skillsRequired;
  final String category;
  final String employmentType;
  final String experienceLevel;
  final String applicationDeadline;
  final bool isBookmarked;

  const JobEntity({
    required this.id,
    required this.companyName,
    required this.logoAsset,
    required this.title,
    required this.salary,
    required this.tags,
    required this.location,
    this.description = '',
    this.responsibilities = const [],
    this.requirements = const [],
    this.skillsRequired = const [],
    this.category = '',
    this.employmentType = '',
    this.experienceLevel = '',
    this.applicationDeadline = '',
    this.isBookmarked = false,
  });

  JobEntity copyWith({
    String? id,
    String? companyName,
    String? logoAsset,
    String? title,
    String? salary,
    List<String>? tags,
    String? location,
    String? description,
    List<String>? responsibilities,
    List<String>? requirements,
    List<String>? skillsRequired,
    String? category,
    String? employmentType,
    String? experienceLevel,
    String? applicationDeadline,
    bool? isBookmarked,
  }) {
    return JobEntity(
      id: id ?? this.id,
      companyName: companyName ?? this.companyName,
      logoAsset: logoAsset ?? this.logoAsset,
      title: title ?? this.title,
      salary: salary ?? this.salary,
      tags: tags ?? this.tags,
      location: location ?? this.location,
      description: description ?? this.description,
      responsibilities: responsibilities ?? this.responsibilities,
      requirements: requirements ?? this.requirements,
      skillsRequired: skillsRequired ?? this.skillsRequired,
      category: category ?? this.category,
      employmentType: employmentType ?? this.employmentType,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      applicationDeadline: applicationDeadline ?? this.applicationDeadline,
      isBookmarked: isBookmarked ?? this.isBookmarked,
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
        description,
        responsibilities,
        requirements,
        skillsRequired,
        category,
        employmentType,
        experienceLevel,
        applicationDeadline,
        isBookmarked,
      ];
}
