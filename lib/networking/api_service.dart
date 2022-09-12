import 'package:cats/networking/fact_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://catfact.ninja/")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/fact")
  Future<List<FactModel>> getFact();
}
