import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  // String userID;

  // UserService() : userID = FirebaseAuth.instance.currentUser!.uid;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> listUsers() {
    return _firestore.collection('usuario').snapshots();
  }

  Future<void> updateTags(List tags) async {
    String userID = 'HGBalCOEImTlNAft5C1ZyOzzN673';
    await _firestore.collection('usuario').doc(userID).update({
      'tags': tags,
    });
  }
}
