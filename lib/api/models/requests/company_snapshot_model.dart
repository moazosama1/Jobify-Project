import 'package:json_annotation/json_annotation.dart';

part 'company_snapshot_model.g.dart';

@JsonSerializable()
class CompanySnapshotModel {
  final String name;
  final String logo;

  CompanySnapshotModel({
    required this.name,
    required this.logo,
  });

  factory CompanySnapshotModel.fromJson(Map<String, dynamic> json) =>
      _$CompanySnapshotModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompanySnapshotModelToJson(this);
}
