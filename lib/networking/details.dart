import 'package:hive/hive.dart';

part 'details.g.dart';

@HiveType(typeId: 1)
class Details {
  Details({required this.fact, required this.time});
  @HiveField(0)
  String fact;

  @HiveField(1)
  DateTime time;
}
