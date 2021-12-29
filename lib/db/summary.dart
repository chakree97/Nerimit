import 'package:hive/hive.dart';

part 'summary.g.dart';

@HiveType(typeId: 0)
class summary extends HiveObject{
  @HiveField(0)
  String name;

  @HiveField(1)
  String background;

  @HiveField(2)
  String head;

  @HiveField(3)
  double rating;

  @HiveField(4)
  List<String> type;

  @HiveField(5)
  int view;

  @HiveField(6)
  String trailer;

  @HiveField(7)
  List<String> director;

  @HiveField(8)
  List<String> actor;

  @HiveField(9)
  String description;

  @HiveField(10)
  String full;

  @HiveField(11)
  String buy;

  summary({
    required this.name,
    required this.background,
    required this.head,
    required this.rating,
    required this.type,
    required this.view,
    required this.trailer,
    required this.director,
    required this.actor,
    required this.description,
    required this.full,
    required this.buy
  });
}