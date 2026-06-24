import 'package:equatable/equatable.dart';

class PaginationEntity extends Equatable {
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final int limit;

  const PaginationEntity({
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
    required this.limit,
  });

  @override
  List<Object?> get props => [currentPage, totalPages, totalCount, limit];
}
