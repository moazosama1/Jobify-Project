import 'package:equatable/equatable.dart';

class SalaryRangeEntity extends Equatable {
  final int min;
  final int max;

  const SalaryRangeEntity({
    required this.min,
    required this.max,
  });

  @override
  List<Object?> get props => [min, max];
}
