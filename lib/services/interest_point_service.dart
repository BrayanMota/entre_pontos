import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entre_pontos/apps/interest_point/model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InterestPointService {
  String userID;

  InterestPointService() : userID = FirebaseAuth.instance.currentUser!.uid;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createInterestPoint(
    InterestPointModel interestPointModel,
  ) async {
    return await _firestore
        .collection('ponto_interesse')
        .doc(interestPointModel.id)
        .set(interestPointModel.toJson());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> listInterestPoints({
    bool todos = false,
  }) {
    if (todos) {
      return _firestore.collection('ponto_interesse').snapshots();
    }
    return _firestore
        .collection('ponto_interesse')
        .where('userID', isEqualTo: userID)
        .snapshots();
  }

  Future<void> updateInterestPoint(
    InterestPointModel interestPointModel,
  ) async {
    return await _firestore
        .collection('ponto_interesse')
        .doc(interestPointModel.id)
        .update(interestPointModel.toJson());
  }

  Future<void> deleteInterestPoint(
    InterestPointModel interestPointModel,
  ) async {
    return await _firestore
        .collection('ponto_interesse')
        .doc(interestPointModel.id)
        .delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> searchUsersInInterestPoint({
    required List<String> users,
  }) {
    return _firestore
        .collection('usuario')
        .where('uid', whereIn: users)
        .snapshots();
  }

  Future<void> addUserToInterestPoint({
    required InterestPointModel interestPointModel,
  }) async {
    List<String> users = interestPointModel.users;
    if (users.contains(userID)) {
      return;
    }
    users.add(userID);
    return await _firestore
        .collection('ponto_interesse')
        .doc(interestPointModel.id)
        .update(
      {
        'users': users,
      },
    );
  }
}
