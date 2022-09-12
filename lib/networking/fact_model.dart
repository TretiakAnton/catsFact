class FactModel {
  FactModel({
    required this.fact,
    required this.length,
  });

  FactModel.fromJson(dynamic json) {
    fact = json['fact'];
    length = json['length'];
  }

  String fact = '';
  int length = 1;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fact'] = fact;
    map['length'] = length;
    return map;
  }
}
