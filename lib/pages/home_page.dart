import 'package:cached_network_image/cached_network_image.dart';
import 'package:cats/bloc/cat_events.dart';
import 'package:cats/bloc/cat_state.dart';
import 'package:cats/bloc/cats_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final CatsBloc bloc = BlocProvider.of<CatsBloc>(context);
    return Scaffold(
      body: Center(
        child: BlocBuilder<CatsBloc, CatState>(
            builder: (BuildContext context, catState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 3,
                child: CachedNetworkImage(
                  imageUrl: 'https://cataas.com/cat',
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                ),
              ),
              Flexible(
                flex: 3,
                child: SingleChildScrollView(child: method1(catState)),
              ),
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CupertinoButton(
                        onPressed: _refreshButton(bloc),
                        child: const Text('Another fact!')),
                    CupertinoButton(
                        onPressed: _showDetailsButton(bloc, context),
                        child: const Text('Fact History'))
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  _refreshButton(CatsBloc bloc) {
    bloc.updateCurrentIndex();
    bloc.add(NewFactEvent());
    print('fact add');
  }

  _showDetailsButton(CatsBloc bloc, BuildContext context) {
    print('histroy add');
    bloc.add(HistoryEvent());

    /*   Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return const HistoryPage();
      }),
    );*/
  }

  method1(CatState state) {
    print('method1');
    if (state is NewFactState) {
      final fact = state.fact;
      print('fact method1 $fact');

      return Container(
        width: 100,
        height: 100,
        color: Colors.green,
        child: Text(
          fact,
          style: TextStyle(color: Colors.black),
        ),
      );
    }
  }
}
