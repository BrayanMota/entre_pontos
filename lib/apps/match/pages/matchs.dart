import 'package:entre_pontos/apps/match/models.dart';
import 'package:entre_pontos/services/route_service.dart';
import 'package:flutter/material.dart';

class ListMatchs extends StatefulWidget {
  const ListMatchs({super.key});

  @override
  State<ListMatchs> createState() => _ListMatchsState();
}

class _ListMatchsState extends State<ListMatchs> {
  final RouteService _routeService = RouteService();
  final userID = RouteService().userID;

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
            List<MatchModel> matchs = [];

            for (var item in snapshot.data!.docs) {
              matchs.add(MatchModel.fromJson(item.data()));
            }

            for (var item in matchs) {
              if (item.userID1 == userID || item.userID1 == userID) {
                item.id = item.userID2;
              }
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
                                Icon(Icons.location_on),
                                const SizedBox(width: 5),
                                Text(matchs[index].id),
                              ],
                            ),
                          ],
                        ),
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
