class RouteModel {
  String userID;
  String id;
  DateTime data;
  bool recorrente;
  int regiaoPartida;
  String bairroPartida;
  int regiaoDestino;
  String bairroDestino;
  List<int> periodos;

  RouteModel({
    this.userID = '',
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
      userID: json['userID'] ?? '',
      id: json['id'] ?? '',
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
      'userID': userID,
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

class MatchModel {
  String id;
  String userID1;
  String userID2;
  String routeID1;
  String routeID2;
  int periodo;
  DateTime data;
  int status1;
  int status2;

  MatchModel({
    required this.id,
    required this.userID1,
    required this.userID2,
    required this.routeID1,
    required this.routeID2,
    required this.periodo,
    required this.data,
    required this.status1,
    required this.status2,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      id: json['id'],
      userID1: json['userID1'],
      userID2: json['userID2'],
      routeID1: json['routeID1'],
      routeID2: json['routeID2'],
      periodo: json['periodo'],
      data: json['data'].toDate(),
      status1: json['status1'],
      status2: json['status2'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userID1': userID1,
      'userID2': userID2,
      'routeID1': routeID1,
      'routeID2': routeID2,
      'periodo': periodo,
      'data': data,
      'status1': status1,
      'status2': status2,
    };
  }
}
