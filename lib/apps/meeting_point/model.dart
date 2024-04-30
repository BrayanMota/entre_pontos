class MeetingPointModel {
  String userID;
  String id;
  DateTime data;
  String hora;
  String partida;
  String chegada;
  List<String> users;

  MeetingPointModel({
    required this.userID,
    required this.id,
    required this.data,
    required this.hora,
    required this.partida,
    required this.chegada,
    this.users = const [],
  });

  factory MeetingPointModel.fromJson(Map<String, dynamic> json) {
    return MeetingPointModel(
      userID: json['userID'] ?? '',
      id: json['id'] ?? '',
      data: json['data'].toDate(),
      hora: json['hora'],
      partida: json['partida'],
      chegada: json['chegada'],
      users: json['users'].cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'id': id,
      'data': data,
      'hora': hora,
      'partida': partida,
      'chegada': chegada,
      'users': users,
    };
  }
}
