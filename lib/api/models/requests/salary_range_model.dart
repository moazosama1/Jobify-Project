class SalaryRangeModel {
  final int min;
  final int max;

  SalaryRangeModel({
    required this.min,
    required this.max,
  });

  factory SalaryRangeModel.fromJson(Map<String, dynamic> json) {
    final minVal = json['min'];
    final maxVal = json['max'];

    return SalaryRangeModel(
      min: minVal is num
          ? minVal.toInt()
          : int.tryParse(minVal?.toString() ?? '') ?? 0,
      max: maxVal is num
          ? maxVal.toInt()
          : int.tryParse(maxVal?.toString() ?? '') ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'min': min,
        'max': max,
      };
}
