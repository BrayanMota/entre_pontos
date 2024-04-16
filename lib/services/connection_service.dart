import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entre_pontos/apps/connection/models.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ConnectionService {
  String userID;

  ConnectionService() : userID = FirebaseAuth.instance.currentUser!.uid;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> listConnections() {
    return _firestore
        .collection('connections')
        .where('userID', isEqualTo: userID)
        .snapshots();
  }

  Future<void> createConnection(
    ConnectionModel connectionModel,
  ) async {
    return await _firestore
        .collection('conexao')
        .doc(connectionModel.id)
        .set(connectionModel.toJson());
  }
}
