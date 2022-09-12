import 'package:cats/mapper.dart';
import 'package:cats/networking/api_service.dart';
import 'package:cats/networking/fact_model.dart';
import 'package:dio/dio.dart' as dio;

class Repo {
  factory Repo() => _instance;
  Repo._();
  static final _instance = Repo._();

  List<FactModel> _facts = <FactModel>[];

  List<FactModel> getFacts() {
    return _facts;
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
      print('teg 121 $response');
      _facts = Mapper().factResponse(response);
      print('teg 122 $_facts');
    } catch (e) {
      print('error123 $e');
    }
  }
}
