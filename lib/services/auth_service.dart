import 'package:entre_pontos/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService _userService = UserService();

  Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  Future<String?> login(String email, String senha) async {
    try {
      if (email.isEmpty || senha.isEmpty) {
        return 'Preencha todos os campos';
      }
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> logout() async {
    return _auth.signOut();
  }

  Future<User?> getUsuarioLogado() async {
    return _auth.currentUser;
  }

  Future<String?> criarUsuario(String nome, String email, String senha) async {
    try {
      if (senha.length < 6) {
        return 'Senha deve ter no mínimo 6 caracteres';
      }
      UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );
      _userService.createUser(nome, email, user.user!.uid);
      if (user.user != null) {
        await user.user!.updateDisplayName(nome);
      }
      return null;
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }
}
