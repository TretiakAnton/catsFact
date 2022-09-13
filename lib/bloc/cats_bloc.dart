import 'package:cats/bloc/cat_events.dart';
import 'package:cats/bloc/cat_state.dart';
import 'package:cats/networking/details.dart';
import 'package:cats/networking/fact_model.dart';
import 'package:cats/networking/repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CatsBloc extends Bloc<CatEvents, CatState> {
  CatsBloc() : super(InitState());
  var _currentFact = 0;
  Repo repo = Repo();
  late Box box;

  @override
  Stream<CatState> mapEventToState(CatEvents event) async* {
    print('newEvent  $event');
    if (event is NewFactEvent) {
      final fact = getNewFact();
      yield NewFactState(fact: fact);
    } else if (event is InitialEvent) {
      await Repo().refresh();
      final fact = getNewFact();
      yield NewFactState(fact: fact);
    } else if (event is HistoryEvent) {
      List<Details> history = [];
      final length = box.length;
      for (int iterations = 0; iterations <= length; iterations++) {
        history.add(box.getAt(iterations));
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
      print('fact $fact');
      box.add(Details(fact: fact, time: DateTime.now()));
      return fact;
    } else {
      return '';
    }
  }
}
