import 'package:equatable/equatable.dart';

class JobEntity extends Equatable {
  final String id;
  final String companyName;
  final String logoAsset;
  final String title;
  final String salary;
  final List<String> tags;
  final String location;
  final bool isBookmarked;

  const JobEntity({
    required this.id,
    required this.companyName,
    required this.logoAsset,
    required this.title,
    required this.salary,
    required this.tags,
    required this.location,
    this.isBookmarked = false,
  });

  JobEntity copyWith({
    String? id,
    String? companyName,
    String? logoAsset,
    String? title,
    String? salary,
    List<String>? tags,
    String? location,
    bool? isBookmarked,
  }) {
    return JobEntity(
      id: id ?? this.id,
      companyName: companyName ?? this.companyName,
      logoAsset: logoAsset ?? this.logoAsset,
      title: title ?? this.title,
      salary: salary ?? this.salary,
      tags: tags ?? this.tags,
      location: location ?? this.location,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }

  @override
  List<Object?> get props => [
        id,
        companyName,
        logoAsset,
        title,
        salary,
        tags,
        location,
        isBookmarked,
      ];
}
