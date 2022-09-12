import 'package:cats/bloc/cat_events.dart';
import 'package:cats/bloc/cats_bloc.dart';
import 'package:cats/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<CatsBloc>(
        create: (_) => CatsBloc(InitialEvent()),
        child: const HomePage(),
      ),
    );
  }
}
