class UsuarioModel {
  String id;
  String nome;
  String email;

  UsuarioModel({
    required this.id,
    required this.nome,
    required this.email,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      id: json['uid'],
      nome: json['nome'],
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
