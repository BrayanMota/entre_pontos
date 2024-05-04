import 'package:entre_pontos/apps/connection/models.dart';
import 'package:entre_pontos/apps/match/models.dart';
import 'package:entre_pontos/services/connection_service.dart';
import 'package:entre_pontos/services/route_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ListMatchs extends StatefulWidget {
  const ListMatchs({super.key});

  @override
  State<ListMatchs> createState() => _ListMatchsState();
}

class _ListMatchsState extends State<ListMatchs> {
  final RouteService _routeService = RouteService();
  final ConnectionService _connectionService = ConnectionService();
  final userID = RouteService().userID;

  @override
  void initState() {
    _routeService.verifyMatches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _routeService.listMatchs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.docs.isNotEmpty) {
            List<MatchModel> matchs = _rulesMatchs(snapshot.data!.docs);

            if (matchs.isEmpty) {
              return const Center(
                child: Text(
                  'Nenhum registro encontrado',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              );
            }

            return Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 20), // Cards
              child: ListView.builder(
                itemCount: matchs.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                      vertical: 25,
                      horizontal: 10,
                    ), // Dentro dos cards
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(matchs[index].id),
                        Text(
                          _formateName(
                            matchs[index].userID1,
                            matchs[index].userID2,
                          ),
                          // _routeService.getUserData(matchs[index].userID2)
                          // 'Nome',
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Email',
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        const SizedBox(height: 50),
                        Text(
                          '${_formateName(matchs[index].userID1, matchs[index].userID2)} fará um trajeto parecido com o seu!',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 50),
                        const Text(
                          'Deseja conversar com este usuário?',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        const SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () {
                                _definirStatus(matchs[index], 2);
                              },
                              child: const Text('Não',
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                            ),
                            const SizedBox(width: 20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              onPressed: () {
                                _definirStatus(matchs[index], 1);
                              },
                              child: const Text('Sim',
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: Text(
                'Nenhum registro encontrado',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            );
          }
        });
  }

  List<MatchModel> _rulesMatchs(matchs) {
    List<MatchModel> matchsList = [];

    for (var item in matchs) {
      final userID1 = item.data()['userID1'];
      final userID2 = item.data()['userID2'];
      final status1 = item.data()['status1'];
      final status2 = item.data()['status2'];
      if (userID1 == userID || userID2 == userID) {
        if (status1 == 1 && status2 == 1) {
          // Se os dois aceitaram, significa que houve um match e vai ser ser salvo a conexão dos dois
          ConnectionModel connectionModel = ConnectionModel(
            userID1: userID1,
            userID2: userID2,
            id: const Uuid().v1(),
          );
          _connectionService.createConnection(connectionModel);
        } else if (status1 == 2 || status2 == 2) {
          // Se um dos dois recusou, não vai ser salvo a conexão e o match vai ser excluído
          _routeService.deleteMatch(item.id);
        }
        if (status1 == 0 || status2 == 0) {
          matchsList.add(MatchModel.fromJson(item.data()));
        } else {
          print('Match já foi aceito ou recusado');
        }
      } else {
        print('Match não é seu');
      }
    }

    return matchsList;
  }

  void _definirStatus(MatchModel matchModel, int status) {
    if (matchModel.userID1 == userID) {
      matchModel.status1 = status;
    } else if (matchModel.userID2 == userID) {
      matchModel.status2 = status;
    }
    _routeService.updateMatch(matchModel);
  }

  String _formateName(String userID1, String userID2) {
    if (userID1 == userID) {
      return 'Você';
    } else if (userID2 == userID) {
      return 'Outro';
    } else {
      return 'Não era';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatPeriod(List<int> period) {
    var periodNames = ['Manhã', 'Tarde', 'Noite'];

    // Mapeando cada item para o nome correspondente e juntando com ', '
    String result = period.map((item) => periodNames[item]).join(', ');

    return result;
  }
}
