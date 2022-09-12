abstract class CatState {}

class NewFactState extends CatState {
  String fact;
  NewFactState({required this.fact});
}
