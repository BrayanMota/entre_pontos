import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entre_pontos/apps/meeting_point/model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MeetingPointService {
  String userID;

  MeetingPointService() : userID = FirebaseAuth.instance.currentUser!.uid;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createMeetingPoint(
    MeetingPointModel meetingPointModel,
  ) async {
    return await _firestore
        .collection('ponto_encontro')
        .doc(meetingPointModel.id)
        .set(meetingPointModel.toJson());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> listMeetingPoints({
    bool todos = false,
  }) {
    if (todos) {
      return _firestore.collection('ponto_encontro').snapshots();
    }
    return _firestore
        .collection('ponto_encontro')
        .where('userID', isEqualTo: userID)
        .snapshots();
  }

  Future<void> updateMeetingPoint(
    MeetingPointModel meetingPointModel,
  ) async {
    return await _firestore
        .collection('ponto_encontro')
        .doc(meetingPointModel.id)
        .update(meetingPointModel.toJson());
  }

  Future<void> deleteMeetingPoint(
    MeetingPointModel meetingPointModel,
  ) async {
    return await _firestore
        .collection('ponto_encontro')
        .doc(meetingPointModel.id)
        .delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> searchUsersInMeetingPoint({
    required List<String> users,
  }) {
    return _firestore
        .collection('usuario')
        .where('uid', whereIn: users)
        .snapshots();
  }

  Future<void> addUserToMeetingPoint({
    required MeetingPointModel meetingPointModel,
  }) async {
    List<String> users = meetingPointModel.users;
    if (users.contains(userID)) {
      return;
    }
    users.add(userID);
    return await _firestore
        .collection('ponto_encontro')
        .doc(meetingPointModel.id)
        .update(
      {
        'users': users,
      },
    );
  }
}
