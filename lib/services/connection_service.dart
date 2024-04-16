import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entre_pontos/apps/connection/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class ConnectionService {
  String userID;

  ConnectionService() : userID = FirebaseAuth.instance.currentUser!.uid;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> listConnections() {
    return _firestore.collection('conexao').snapshots();
  }

  Future<void> createConnection(
    ConnectionModel connectionModel,
  ) async {
    return await _firestore
        .collection('conexao')
        .doc(connectionModel.id)
        .set(connectionModel.toJson());
  }

  verifyConnections(ConnectionModel model) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('conexao').get();

    if (snapshot.docs.isEmpty) {
      createConnection(model);
    }
    for (var item in snapshot.docs) {
      ConnectionModel connectionModel = ConnectionModel.fromJson(item.data());
      // }

      // for (var connection in connections) {
      //   ConnectionModel connectionModel = ConnectionModel(
      //     id: connection.id,
      //     userID1: connection.userID1,
      //     userID2: connection.userID2,
      //   );

      // Antes de criar um match, verifica se já existe um match com esses usuários, data, periodo e rotas
      QuerySnapshot<Map<String, dynamic>> connectionSnapshot = await _firestore
          .collection('match')
          .where('userID1', isEqualTo: connectionModel.userID1)
          .where('userID2', isEqualTo: connectionModel.userID2)
          .get();

      if (connectionSnapshot.docs.isEmpty) {
        createConnection(model);
      }
    }
  }
}
