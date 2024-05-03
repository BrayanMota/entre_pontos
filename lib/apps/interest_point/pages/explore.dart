import 'package:entre_pontos/apps/interest_point/model.dart';
import 'package:entre_pontos/apps/user/model.dart';
import 'package:entre_pontos/services/interest_point_service.dart';
import 'package:flutter/material.dart';

class ExploreInterestPointsPage extends StatefulWidget {
  const ExploreInterestPointsPage({super.key});

  @override
  State<ExploreInterestPointsPage> createState() =>
      _ExploreInterestPointsPageState();
}

class _ExploreInterestPointsPageState extends State<ExploreInterestPointsPage> {
  final InterestPointService _interestPointService = InterestPointService();
  String userID = '';

  @override
  void initState() {
    super.initState();
    userID = _interestPointService.userID;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _interestPointService.listInterestPoints(todos: true),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data!.docs.isNotEmpty) {
          List<InterestPointModel> interestpoints = [];

          for (var item in snapshot.data!.docs) {
            interestpoints.add(InterestPointModel.fromJson(item.data()));
          }

          return Container(
            padding: const EdgeInsets.symmetric(
                vertical: 10, horizontal: 20), // Cards
            child: ListView.builder(
              itemCount: interestpoints.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return CustomInterestPointModal(
                          interestPointModel: interestpoints[index],
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 10,
                    ), // Dentro dos cards
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (interestpoints[index].userID == userID)
                              const Text(
                                'Seu ponto de interesse',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            Row(
                              children: [
                                const Icon(Icons.location_on),
                                const SizedBox(width: 5),
                                Text(interestpoints[index].local),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(Icons.description),
                                const SizedBox(width: 5),
                                Text(interestpoints[index].descricao),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                                'Participantes: ${interestpoints[index].users.length}'),
                          ],
                        ),
                        Column(
                          children: [
                            Text(_formatDate(interestpoints[index].data)),
                            const SizedBox(height: 5),
                            Text(interestpoints[index].hora),
                          ],
                        ),
                      ],
                    ),
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
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class CustomInterestPointModal extends StatelessWidget {
  final InterestPointService _interestPointService = InterestPointService();
  InterestPointModel interestPointModel;

  CustomInterestPointModal({
    required this.interestPointModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 20,
      ),
      child: Column(
        children: [
          const Text(
            'Confirmar presença?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Deseja confirmar presença neste ponto de encontro?',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          StreamBuilder(
            stream: _interestPointService.searchUsersInInterestPoint(
              users: interestPointModel.users,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData &&
                  snapshot.data != null &&
                  snapshot.data!.docs.isNotEmpty) {
                List<UserModal> usuarios = [];

                for (var item in snapshot.data!.docs) {
                  usuarios.add(UserModal.fromJson(item.data()));
                }

                return SizedBox(
                  height: 50,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: usuarios.length,
                    itemBuilder: (context, index) {
                      return CircleAvatar(
                        child: Text(_take3Chars(usuarios[index].nome)),
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
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Voltar'),
              ),
              ElevatedButton(
                onPressed: () {
                  _interestPointService.addUserToInterestPoint(
                    interestPointModel: interestPointModel,
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                child: const Text(
                  'Confirmar presença',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _take3Chars(String text) {
    return text.substring(0, 3);
  }
}
