import 'package:equatable/equatable.dart';

class EducationEntity extends Equatable {
  final String id;
  final String institution;
  final String degree;
  final String fieldOfStudy;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isCurrent;
  final String description;

  const EducationEntity({
    required this.id,
    required this.institution,
    required this.degree,
    required this.fieldOfStudy,
    this.startDate,
    this.endDate,
    this.isCurrent = false,
    this.description = '',
  });

  factory EducationEntity.fromMap(Map<String, dynamic> map) {
    return EducationEntity(
      id: map['_id'] ?? '',
      institution: map['institution'] ?? '',
      degree: map['degree'] ?? '',
      fieldOfStudy: map['fieldOfStudy'] ?? '',
      startDate: map['startDate'] != null ? DateTime.tryParse(map['startDate']) : null,
      endDate: map['endDate'] != null ? DateTime.tryParse(map['endDate']) : null,
      isCurrent: map['isCurrent'] ?? false,
      description: map['description'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, institution, degree, fieldOfStudy, startDate, endDate, isCurrent, description];
}
