import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  Future<String?> login(String email, String senha) async {
    try {
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
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: senha);
      if (user.user != null) {
        await user.user!.updateDisplayName(nome);
      }
      return null;
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }
}
