import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entre_pontos/apps/user/model.dart';

class UserService {
  // String userID;

  // UserService() : userID = FirebaseAuth.instance.currentUser!.uid;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(String name, String email, String id) async {
    await _firestore.collection('usuario').doc(id).set({
      'name': name,
      'email': email,
      'uid': id,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> listUsers() {
    return _firestore.collection('usuario').snapshots();
  }

  Future<void> updateTags(List tags) async {
    await _firestore
        .collection('usuario')
        .doc('c0eQ4jLeZQgspBvWZ4NMA8najiO2')
        .update({
      'tags': tags,
    });
  }
}
