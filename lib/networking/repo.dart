import 'package:cats/mapper.dart';
import 'package:cats/networking/api_service.dart';
import 'package:cats/networking/fact_model.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';

class Repo {
  factory Repo() => _instance;

  Repo._();

  static final _instance = Repo._();

  List<FactModel> _facts = <FactModel>[];

  List<FactModel> getFacts() {
    return _facts;
  }

  int getFactsCount() {
    return _facts.length;
  }

  FactModel? getFactsAtIndex(int index) {
    if (_facts.isEmpty) {
      return null;
    }
    return _facts.elementAt(index);
  }

  Future<void> refresh() {
    return _loadFacts();
  }

  Future<void> _loadFacts() async {
    try {
      final ApiService apiService = ApiService(dio.Dio());
      final response = await apiService.getFact();
      _facts = Mapper().factResponse(response);
    } catch (e) {
      if (kDebugMode) {
        print('error123 $e');
      }
    }
  }
}
