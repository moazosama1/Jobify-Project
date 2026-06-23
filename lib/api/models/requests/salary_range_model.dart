import 'package:json_annotation/json_annotation.dart';

part 'salary_range_model.g.dart';

@JsonSerializable()
class SalaryRangeModel {
  final int min;
  final int max;

  SalaryRangeModel({
    required this.min,
    required this.max,
  });

  factory SalaryRangeModel.fromJson(Map<String, dynamic> json) =>
      _$SalaryRangeModelFromJson(json);

  Map<String, dynamic> toJson() => _$SalaryRangeModelToJson(this);
}
