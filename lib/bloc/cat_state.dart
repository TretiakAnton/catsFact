import 'package:cats/networking/details.dart';

abstract class CatState {}

class NewFactState extends CatState {
  String fact;

  NewFactState({required this.fact});
}

class HistoryState extends CatState {
  List<Details> history;

  HistoryState({required this.history});
}

class InitState extends CatState {}
