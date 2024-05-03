import 'package:entre_pontos/apps/interest_point/model.dart';
import 'package:entre_pontos/services/interest_point_service.dart';
import 'package:flutter/material.dart';

class MyInterestPointsPage extends StatefulWidget {
  const MyInterestPointsPage({super.key});

  @override
  State<MyInterestPointsPage> createState() => _MyInterestPointsPageState();
}

class _MyInterestPointsPageState extends State<MyInterestPointsPage> {
  final InterestPointService _interestPointService = InterestPointService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _interestPointService.listInterestPoints(),
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
        });
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
            'Excluir ponto de encontro',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Deseja realmente excluir este ponto de encontro?',
            style: TextStyle(
              fontSize: 16,
            ),
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
                  _interestPointService.deleteInterestPoint(interestPointModel);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                child: const Text(
                  'Excluir',
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
}
