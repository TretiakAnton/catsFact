import 'package:cats/bloc/cat_events.dart';
import 'package:cats/bloc/cats_bloc.dart';
import 'package:flutter/cupertino.dart';

class ButtonController {
  ButtonController({required this.bloc});

  DateTime lastCall = DateTime.now();
  CatsBloc bloc;

  newFact() {
    var now = DateTime.now();
    if (now.minute != lastCall.minute) {
      bloc.add(NewFactEvent());
      print('fact add');
    }
    lastCall = now;
  }

  historyPage(BuildContext context) {
    var now = DateTime.now();
    if (now.minute != lastCall.minute) {
      print('histroy add');
      bloc.add(HistoryEvent());
    }
    lastCall = now;
    /*   Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return const HistoryPage();
      }),
    );*/
  }
}
