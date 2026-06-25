import 'package:equatable/equatable.dart';

class ExperienceRequestEntity extends Equatable {
  final String? company;
  final String? position;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool? isCurrent;
  final String? description;

  const ExperienceRequestEntity({
    this.company,
    this.position,
    this.startDate,
    this.endDate,
    this.isCurrent,
    this.description,
  });

  @override
  List<Object?> get props => [
        company,
        position,
        startDate,
        endDate,
        isCurrent,
        description,
      ];
}
