import 'package:objectbox/objectbox.dart';

@Entity()
class RecentSearchModel {
  @Id()
  int id;

  final String query;

  RecentSearchModel({this.id = 0, required this.query});
}
