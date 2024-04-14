import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entre_pontos/apps/match/models.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RouteService {
  String userID;

  RouteService() : userID = FirebaseAuth.instance.currentUser!.uid;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createRoute(RouteModel routeModel) async {
    return await _firestore
        .collection(userID)
        .doc(routeModel.id)
        .set(routeModel.toJson());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> listRoutes() {
    return _firestore.collection(userID).snapshots();
  }
}
