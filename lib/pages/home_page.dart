import 'package:cached_network_image/cached_network_image.dart';
import 'package:cats/bloc/cat_events.dart';
import 'package:cats/bloc/cat_state.dart';
import 'package:cats/bloc/cats_bloc.dart';
import 'package:cats/pages/history_page.dart';
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
              const Flexible(
                flex: 3,
                child: SingleChildScrollView(),
              ),
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                        onPressed: _refresh(bloc),
                        child: const Text('Another fact!')),
                    OutlinedButton(
                        onPressed: _showDetails(bloc, context),
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

  _refresh(CatsBloc bloc) {
    bloc.add(NewFactEvent());
  }

  _showDetails(CatsBloc bloc, BuildContext context) {
    bloc.add(HistoryEvent());
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return const HistoryPage();
      }),
    );
  }
}
