import 'package:json_annotation/json_annotation.dart';

part 'pagination_model.g.dart';

int? _toInt(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toInt();
  if (value is String) {
    if (value.isEmpty) return null;
    return int.tryParse(value);
  }
  return null;
}

@JsonSerializable()
class PaginationModel {
  @JsonKey(name: 'current_page', fromJson: _toInt)
  final int? currentPage;
  @JsonKey(name: 'total_pages', fromJson: _toInt)
  final int? totalPages;
  @JsonKey(name: 'total_count', fromJson: _toInt)
  final int? totalCount;
  @JsonKey(fromJson: _toInt)
  final int? limit;

  PaginationModel({
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.limit,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) => _$PaginationModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationModelToJson(this);
}
