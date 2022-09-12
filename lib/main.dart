import 'package:cats/bloc/cats_bloc.dart';
import 'package:cats/networking/repo.dart';
import 'package:cats/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  //await Hive.initFlutter();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          future: Repo().refresh(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return BlocProvider<CatsBloc>(
                create: (_) => CatsBloc(),
                child: const HomePage(),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
