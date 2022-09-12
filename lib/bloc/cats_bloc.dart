import 'package:cats/bloc/cat_events.dart';
import 'package:cats/bloc/cat_state.dart';
import 'package:cats/networking/details.dart';
import 'package:cats/networking/fact_model.dart';
import 'package:cats/networking/repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CatsBloc extends Bloc<CatEvents, CatState> {
  CatsBloc([CatEvents? event]) : super(LoadFactState());
  var _currentFact = 0;
  Repo repo = Repo();

  @override
  Stream<CatState> mapEventToState(CatEvents event) async* {
    print('newEvent  $event');
    Box box;
    box = await Hive.openBox('factsBox');
    if (event is NewFactEvent) {
      final fact = getCurrentFact()?.fact;
      if (fact != null) {
        //box.put(fact, DateTime.now());
        yield NewFactState(fact: fact);
      }
    } else if (event is InitialEvent) {
      Hive.registerAdapter(DetailsAdapter());
    }
  }

  FactModel? getCurrentFact() {
    return repo.getFactsAtIndex(_currentFact);
  }

  updateCurrentIndex() {
    _currentFact++;
  }
}
