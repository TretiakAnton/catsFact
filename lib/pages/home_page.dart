import 'package:cached_network_image/cached_network_image.dart';
import 'package:cats/bloc/cat_events.dart';
import 'package:cats/bloc/cat_state.dart';
import 'package:cats/bloc/cats_bloc.dart';
import 'package:cats/button_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CatsBloc bloc = BlocProvider.of<CatsBloc>(context);
    bloc.add(InitialEvent());
    ButtonController controller = ButtonController(bloc: bloc);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              flex: 4,
              child: BlocBuilder<CatsBloc, CatState>(
                  builder: (BuildContext context, catState) {
                return Column(
                  children: [
                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: CachedNetworkImage(
                          imageUrl: 'https://cataas.com/cat',
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SingleChildScrollView(
                          child: factWidget(catState),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton(
                      onPressed: controller.newFact(),
                      child: const Text('Another fact!')),
                  OutlinedButton(
                      onPressed: controller.historyPage(context),
                      child: const Text('Fact History'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  factWidget(CatState state) {
    if (state is NewFactState) {
      final fact = state.fact;
      return Text(fact);
    } else {
      return const Text('Is loading');
    }
  }
}
