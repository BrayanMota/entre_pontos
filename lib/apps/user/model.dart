class UserModel {
  String id;
  String nome;
  String email;
  String senha;
  List<dynamic> tags;

  UserModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
    required this.tags,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['uid'],
      nome: json['name'],
      email: json['email'],
      senha: '',
      tags: json['tags'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'senha': senha,
      'tags': tags,
    };
  }
}
