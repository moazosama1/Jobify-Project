class GetAllJobsRequestEntity {
  final int? page;
  final int? limit;
  final String? search;
  final String? location;
  final String? employmentType;
  final String? experienceLevel;
  final String? category;
  final bool? isRemote;
  final num? minSalary;
  final num? maxSalary;
  final String? status;
  final String? sortBy;
  final String? sortOrder;

  const GetAllJobsRequestEntity({
    this.page,
    this.limit,
    this.search,
    this.location,
    this.employmentType,
    this.experienceLevel,
    this.category,
    this.isRemote,
    this.minSalary,
    this.maxSalary,
    this.status,
    this.sortBy,
    this.sortOrder,
  });

  Map<String, dynamic> toMap() {
    return {
      if (page != null) 'page': page,
      if (limit != null) 'limit': limit,
      if (search != null) 'search': search,
      if (location != null) 'location': location,
      if (employmentType != null) 'employmentType': employmentType,
      if (experienceLevel != null) 'experienceLevel': experienceLevel,
      if (category != null) 'category': category,
      if (isRemote != null) 'isRemote': isRemote,
      if (minSalary != null) 'minSalary': minSalary,
      if (maxSalary != null) 'maxSalary': maxSalary,
      if (status != null) 'status': status,
      if (sortBy != null) 'sortBy': sortBy,
      if (sortOrder != null) 'sortOrder': sortOrder,
    };
  }
}
