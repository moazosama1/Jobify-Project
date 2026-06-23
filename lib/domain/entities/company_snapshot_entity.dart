import 'package:equatable/equatable.dart';

class CompanySnapshotEntity extends Equatable {
  final String name;
  final String logo;

  const CompanySnapshotEntity({
    required this.name,
    required this.logo,
  });

  @override
  List<Object?> get props => [name, logo];
}
