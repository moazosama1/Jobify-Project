import 'package:equatable/equatable.dart';

class EducationRequestEntity extends Equatable {
  final String? institution;
  final String? degree;
  final String? fieldOfStudy;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool? isCurrent;
  final String? description;

  const EducationRequestEntity({
    this.institution,
    this.degree,
    this.fieldOfStudy,
    this.startDate,
    this.endDate,
    this.isCurrent,
    this.description,
  });

  @override
  List<Object?> get props => [
        institution,
        degree,
        fieldOfStudy,
        startDate,
        endDate,
        isCurrent,
        description,
      ];
}
