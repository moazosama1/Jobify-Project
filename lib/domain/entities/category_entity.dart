import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String id;
  final String nameKey;
  final String icon;

  const CategoryEntity({
    required this.id,
    required this.nameKey,
    required this.icon,
  });

  @override
  List<Object?> get props => [id, nameKey, icon];
}
