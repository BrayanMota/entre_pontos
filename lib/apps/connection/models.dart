class ConnectionModel {
  String userID1;
  String userID2;
  String id;

  ConnectionModel({
    required this.userID1,
    required this.userID2,
    required this.id,
  });

  factory ConnectionModel.fromJson(Map<String, dynamic> json) {
    return ConnectionModel(
      userID1: json['userID1'],
      userID2: json['userID2'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userID1': userID1,
      'userID2': userID2,
      'id': id,
    };
  }
}