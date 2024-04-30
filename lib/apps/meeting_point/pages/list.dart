import 'package:entre_pontos/apps/users/model.dart';
import 'package:entre_pontos/apps/meeting_point/model.dart';
import 'package:entre_pontos/services/meeting_point_service.dart';
import 'package:flutter/material.dart';

class MyMeetingPointsPage extends StatefulWidget {
  const MyMeetingPointsPage({super.key});

  @override
  State<MyMeetingPointsPage> createState() => _MyMeetingPointsPageState();
}

class _MyMeetingPointsPageState extends State<MyMeetingPointsPage> {
  final MeetingPointService _meetingPointService = MeetingPointService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _meetingPointService.listMeetingPoints(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.docs.isNotEmpty) {
            List<MeetingPointModel> meetingpoints = [];

            for (var item in snapshot.data!.docs) {
              meetingpoints.add(MeetingPointModel.fromJson(item.data()));
            }

            return Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 20), // Cards
              child: ListView.builder(
                itemCount: meetingpoints.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return CustomMeetingPointModal(
                            meetingPointModel: meetingpoints[index],
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
                                  Text(meetingpoints[index].partida),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(Icons.arrow_forward),
                                  const SizedBox(width: 5),
                                  Text(meetingpoints[index].chegada),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                  'Participantes: ${meetingpoints[index].users.length}'),
                            ],
                          ),
                          Column(
                            children: [
                              Text(_formatDate(meetingpoints[index].data)),
                              const SizedBox(height: 5),
                              Text(meetingpoints[index].hora),
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

class CustomMeetingPointModal extends StatelessWidget {
  final MeetingPointService _meetingPointService = MeetingPointService();
  MeetingPointModel meetingPointModel;

  CustomMeetingPointModal({
    required this.meetingPointModel,
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
                  _meetingPointService.deleteMeetingPoint(meetingPointModel);
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
