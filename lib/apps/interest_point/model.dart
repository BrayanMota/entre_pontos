class InterestPointModel {
  String userID;
  String id;
  DateTime data;
  String hora;
  String local;
  String descricao;
  List<String> users;

  InterestPointModel({
    required this.userID,
    required this.id,
    required this.data,
    required this.hora,
    required this.local,
    required this.descricao,
    this.users = const [],
  });

  factory InterestPointModel.fromJson(Map<String, dynamic> json) {
    return InterestPointModel(
      userID: json['userID'] ?? '',
      id: json['id'] ?? '',
      data: json['data'].toDate(),
      hora: json['hora'],
      local: json['local'],
      descricao: json['descricao'],
      users: json['users'].cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'id': id,
      'data': data,
      'hora': hora,
      'local': local,
      'descricao': descricao,
      'users': users,
    };
  }
}
