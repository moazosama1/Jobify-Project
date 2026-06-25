import 'package:equatable/equatable.dart';

class ApplicationStatsEntity extends Equatable {
  final int total;
  final int pending;
  final int reviewed;
  final int interview;
  final int accepted;
  final int rejected;
  final int? activeJobs;

  const ApplicationStatsEntity({
    required this.total,
    required this.pending,
    required this.reviewed,
    required this.interview,
    required this.accepted,
    required this.rejected,
    this.activeJobs,
  });

  @override
  List<Object?> get props => [
        total,
        pending,
        reviewed,
        interview,
        accepted,
        rejected,
        activeJobs,
      ];
}
