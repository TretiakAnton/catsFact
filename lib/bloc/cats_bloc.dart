import 'package:cats/bloc/cat_events.dart';
import 'package:cats/bloc/cat_state.dart';
import 'package:cats/networking/box_manager.dart';
import 'package:cats/networking/details.dart';
import 'package:cats/networking/fact_model.dart';
import 'package:cats/networking/repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatsBloc extends Bloc<CatEvents, CatState> {
  CatsBloc() : super(InitState());
  var _currentFact = 0;
  Repo repo = Repo();
  final box = BoxManager.getBox;

  @override
  Stream<CatState> mapEventToState(CatEvents event) async* {
    if (event is NewFactEvent) {
      if (_currentFact <= Repo().getFactsCount()) {
        await Repo().refresh();
      }
      final fact = getNewFact();
      yield NewFactState(fact: fact);
    } else if (event is InitialEvent) {
      await Repo().refresh();
      final fact = getNewFact();
      yield NewFactState(fact: fact);
    } else if (event is HistoryEvent) {
      List<Details> history = [];
      final length = box.call().length;
      for (int iterations = 0; iterations <= length; iterations++) {
        final detail = box.call().getAt(iterations);
        if (detail is Details) {
          history.add(detail);
        }
      }
      yield HistoryState(history: history);
    }
  }

  FactModel? getCurrentFact() {
    return repo.getFactsAtIndex(_currentFact);
  }

  updateCurrentIndex() {
    _currentFact++;
  }

  String getNewFact() {
    final fact = getCurrentFact()?.fact;
    if (fact != null) {
      updateCurrentIndex();
      box.call().add(Details(fact: fact, time: DateTime.now()));
      return fact;
    } else {
      return '';
    }
  }
}
