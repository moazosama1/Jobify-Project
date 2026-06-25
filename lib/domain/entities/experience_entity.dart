import 'package:equatable/equatable.dart';

class ExperienceEntity extends Equatable {
  final String id;
  final String company;
  final String position;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isCurrent;
  final String description;

  const ExperienceEntity({
    required this.id,
    required this.company,
    required this.position,
    this.startDate,
    this.endDate,
    this.isCurrent = false,
    this.description = '',
  });

  factory ExperienceEntity.fromMap(Map<String, dynamic> map) {
    return ExperienceEntity(
      id: map['_id'] ?? '',
      company: map['company'] ?? '',
      position: map['position'] ?? '',
      startDate: map['startDate'] != null ? DateTime.tryParse(map['startDate']) : null,
      endDate: map['endDate'] != null ? DateTime.tryParse(map['endDate']) : null,
      isCurrent: map['isCurrent'] ?? false,
      description: map['description'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, company, position, startDate, endDate, isCurrent, description];
}
