abstract class CatState {}

class NewFactState extends CatState {
  String fact;
  NewFactState({required this.fact});
}

class LoadFactState extends CatState {}

class InitState extends CatState {}
