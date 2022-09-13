import 'package:cats/bloc/cat_events.dart';
import 'package:cats/bloc/cat_state.dart';
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
      final fact = getCurrentFact()?.fact;
      if (fact != null) {
        updateCurrentIndex();
        print('fact $fact');
        //box.put(fact, DateTime.now());
        yield NewFactState(fact: fact);
      }
    } else if (event is InitialEvent) {
      await Repo().refresh();
      //box = await Hive.openBox('factsBox');
      //Hive.registerAdapter(DetailsAdapter());
      yield InitState();
    }
  }

  FactModel? getCurrentFact() {
    return repo.getFactsAtIndex(_currentFact);
  }

  updateCurrentIndex() {
    _currentFact++;
  }
}
