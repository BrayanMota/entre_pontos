import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entre_pontos/apps/match/functions.dart';
import 'package:entre_pontos/apps/match/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class RouteService {
  String userID;

  RouteService() : userID = FirebaseAuth.instance.currentUser!.uid;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createRoute(
    RouteModel routeModel,
  ) async {
    return await _firestore
        // .collection(userID)
        .collection('trajeto')
        .doc(routeModel.id)
        .set(routeModel.toJson());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> listRoutes() {
    return _firestore
        .collection('trajeto')
        .where('userID', isEqualTo: userID)
        .snapshots();
  }

  Future<void> verifyMatches() async {
    // Obtém a data e hora atuais
    DateTime now = DateTime.now();
    // Ajusta para o começo do dia (meia-noite)
    DateTime startOfToday = DateTime(now.year, now.month, now.day);

    // Obtém todos os trajetos do usuário
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('trajeto')
        .where('data', isGreaterThanOrEqualTo: startOfToday)
        .get();

    List<RouteModel> routes = [];
    for (var item in snapshot.docs) {
      routes.add(RouteModel.fromJson(item.data()));
    }

    // Depois de carregar todos os dados
    List<RouteModel> expandedRoutes = RouteFuncionts().expandRoutes(routes);
    Map<String, List<RouteModel>> groupedRoutes =
        RouteFuncionts().groupRoutes(expandedRoutes);

    // Verifica se há matches
    for (var key in groupedRoutes.keys) {
      List<RouteModel> routes = groupedRoutes[key]!;
      if (routes.length > 1) {
        MatchModel matchModel = MatchModel(
          id: const Uuid().v1(),
          userID1: routes[0].userID,
          userID2: routes[1].userID,
          data: routes[0].data,
          routeID1: routes[0].id,
          routeID2: routes[1].id,
          periodo: routes[0].periodos.first,
          status1: 0,
          status2: 0,
        );

        // Antes de criar um match, verifica se já existe um match com esses usuários, data, periodo e rotas
        QuerySnapshot<Map<String, dynamic>> matchSnapshot = await _firestore
            .collection('match')
            .where('userID1', isEqualTo: matchModel.userID1)
            .where('userID2', isEqualTo: matchModel.userID2)
            .where('data', isEqualTo: matchModel.data)
            .where('periodo', isEqualTo: matchModel.periodo)
            .where('routeID1', isEqualTo: matchModel.routeID1)
            .where('routeID2', isEqualTo: matchModel.routeID2)
            .get();

        if (matchSnapshot.docs.isEmpty) {
          createMatch(matchModel);
        }
      }
    }
  }

  Future<void> createMatch(MatchModel matchModel) async {
    return await _firestore
        .collection('match')
        .doc(matchModel.id)
        .set(matchModel.toJson());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> listMatchs() {
    DateTime now = DateTime.now(); // Obtém a data e hora atuais
    DateTime startOfToday = DateTime(
      now.year,
      now.month,
      now.day,
    ); // Ajusta para o começo do dia (meia-noite)

    return _firestore
        .collection('match')
        .where('data', isGreaterThanOrEqualTo: startOfToday)
        .snapshots();
  }

  Future<String> getUserData(String userID) async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('usuarios');

    DocumentSnapshot documentSnapshot = await usersCollection.doc(userID).get();
    if (documentSnapshot.exists) {
      // O documento existe, você pode acessar os dados assim:
      Map<String, dynamic>? userData =
          documentSnapshot.data() as Map<String, dynamic>?;

      // Supondo que 'displayName' é o campo que contém o nome do usuário
      String displayName = userData?['nome'] ?? 'Não achou o nome';
      return displayName;
    } else {
      return 'Sem nome';
    }
  }

  Future<void> updateMatch(MatchModel matchModel) async {
    return await _firestore
        .collection('match')
        .doc(matchModel.id)
        .update(matchModel.toJson());
  }

  Future<void> deleteMatch(String id) async {
    return await _firestore.collection('match').doc(id).delete();
  }
}
