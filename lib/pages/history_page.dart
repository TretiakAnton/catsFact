import 'package:cats/bloc/cat_events.dart';
import 'package:cats/bloc/cat_state.dart';
import 'package:cats/bloc/cats_bloc.dart';
import 'package:cats/networking/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);
  final route = '/history';

  @override
  Widget build(BuildContext context) {
    final CatsBloc bloc = BlocProvider.of<CatsBloc>(context);
    bloc.add(HistoryEvent());
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            BlocBuilder<CatsBloc, CatState>(
              builder: (BuildContext context, catState) {
                if (catState is HistoryState) {
                  return SingleChildScrollView(
                      child: _parseText(catState.history));
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
                bloc.add(NewFactEvent());
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }

  _parseText(List<Details> history) {
    String answer = '';
    for (var value in history) {
      answer += '''${value.fact} was shown at ${value.time.toString()} \n''';
    }
    return Text(answer);
  }
}
