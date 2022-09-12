import 'package:cats/bloc/cat_events.dart';
import 'package:cats/bloc/cat_state.dart';
import 'package:cats/networking/api_service.dart';
import 'package:cats/networking/details.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CatsBloc extends Bloc<CatEvents, CatState> {
  CatsBloc([CatEvents? event]) : super(NewFactState(fact: ''));
  final ApiService apiService = ApiService(dio.Dio());
  @override
  Stream<CatState> mapEventToState(CatEvents event) async* {
    Box box;
    box = await Hive.openBox('factsBox');
    if (event is NewFactEvent) {
      final response = await apiService.getFact();
      String fact = response.first.fact;
      box.put(fact, DateTime.now());
      yield NewFactState(fact: fact);
    } else if (event is InitialEvent) {
      Hive.registerAdapter(DetailsAdapter());
    }
  }
}
