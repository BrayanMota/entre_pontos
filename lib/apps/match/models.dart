class RouteModel {
  String id;
  DateTime data;
  bool recorrente;
  int regiaoPartida;
  String bairroPartida;
  int regiaoDestino;
  String bairroDestino;
  List<int> periodos;

  RouteModel({
    required this.id,
    required this.data,
    required this.recorrente,
    required this.regiaoPartida,
    required this.bairroPartida,
    required this.regiaoDestino,
    required this.bairroDestino,
    required this.periodos,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      id: json['id'],
      data: json['data'].toDate(),
      recorrente: json['recorrente'],
      regiaoPartida: json['regiaoPartida'],
      bairroPartida: json['bairroPartida'],
      regiaoDestino: json['regiaoDestino'],
      bairroDestino: json['bairroDestino'],
      periodos: json['periodos'].cast<int>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'data': data,
      'recorrente': recorrente,
      'regiaoPartida': regiaoPartida,
      'bairroPartida': bairroPartida,
      'regiaoDestino': regiaoDestino,
      'bairroDestino': bairroDestino,
      'periodos': periodos,
    };
  }
}
