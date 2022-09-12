import 'package:cats/networking/fact_model.dart';

class Mapper {
  List<FactModel> factResponse(dynamic response) {
    final List dataList = response['data'];
    List<FactModel> facts = dataList.map((e) => FactModel.fromJson(e)).toList();
    return facts;
  }
}
