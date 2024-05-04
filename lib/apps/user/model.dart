class UserModel {
  String id;
  String nome;
  String email;
  List<String> tags = [];

  UserModel({
    required this.id,
    required this.nome,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['uid'],
      nome: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
    };
  }
}
