import 'package:cats/networking/details.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BoxManager {
  static Box<Details> getBox() {
    return Hive.box<Details>('factsBox');
  }
}
