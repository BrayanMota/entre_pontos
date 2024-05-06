import 'package:entre_pontos/apps/user/model.dart';
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

  Future<User?> getUser() async {
    return _auth.currentUser;
  }

  Future<String?> register(UserModel userModel) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: userModel.email,
        password: userModel.senha,
      );
      userModel.id = user.user!.uid;
      _userService.createUser(userModel);
      if (user.user != null) {
        await user.user!.updateDisplayName(userModel.nome);
      }
      return null;
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }
}
