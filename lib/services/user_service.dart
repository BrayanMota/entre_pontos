import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entre_pontos/apps/user/model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    await _firestore.collection('usuario').doc(user.id).set({
      'uid': user.id,
      'name': user.nome,
      'email': user.email,
      'tags': user.tags,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> listUsers() {
    return _firestore.collection('usuario').snapshots();
  }
}
