import 'package:equatable/equatable.dart';

class UpdateSkillsRequestEntity extends Equatable {
  final List<String> skills;

  const UpdateSkillsRequestEntity({
    required this.skills,
  });

  @override
  List<Object?> get props => [skills];
}
