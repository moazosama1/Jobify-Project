import 'package:json_annotation/json_annotation.dart';

part 'pagination_model.g.dart';

@JsonSerializable()
class PaginationModel {
  @JsonKey(name: 'current_page')
  final int? currentPage;
  @JsonKey(name: 'total_pages')
  final int? totalPages;
  @JsonKey(name: 'total_count')
  final int? totalCount;
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
