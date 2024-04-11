class MatchModel {
  String id;
  String data;
  bool recorrente;
  int regiaoPartida;
  String bairroPartida;
  int regiaoDestino;
  String bairroDestino;
  List<int> periodos;
  String createdBy;
  String createdAt;
  String updatedAt;

  MatchModel({
    required this.id,
    required this.data,
    required this.recorrente,
    required this.regiaoPartida,
    required this.bairroPartida,
    required this.regiaoDestino,
    required this.bairroDestino,
    required this.periodos,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      id: json['id'],
      data: json['data'],
      recorrente: json['recorrente'],
      regiaoPartida: json['regiaoPartida'],
      bairroPartida: json['bairroPartida'],
      regiaoDestino: json['regiaoDestino'],
      bairroDestino: json['bairroDestino'],
      periodos: json['periodos'].cast<int>(),
      createdBy: json['createdBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
