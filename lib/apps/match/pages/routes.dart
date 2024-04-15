import 'package:entre_pontos/apps/match/functions.dart';
import 'package:entre_pontos/apps/match/models.dart';
import 'package:entre_pontos/services/route_service.dart';
import 'package:flutter/material.dart';

class ListRoutes extends StatefulWidget {
  const ListRoutes({super.key});

  @override
  State<ListRoutes> createState() => _ListRoutesState();
}

class _ListRoutesState extends State<ListRoutes> {
  final RouteService _routeService = RouteService();

  @override
  void initState() {
    _routeService.verifyMatches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _routeService.listRoutes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.docs.isNotEmpty) {
            List<RouteModel> routes = [];

            for (var item in snapshot.data!.docs) {
              routes.add(RouteModel.fromJson(item.data()));
            }

            return Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 20), // Cards
              child: ListView.builder(
                itemCount: routes.length,
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
                                Text(routes[index].bairroPartida),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(Icons.arrow_forward),
                                const SizedBox(width: 5),
                                Text(routes[index].bairroDestino),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(Icons.repeat),
                                const SizedBox(width: 5),
                                Text(
                                  routes[index].recorrente
                                      ? 'Recorrente'
                                      : 'Não recorrente',
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(Icons.calendar_today),
                                const SizedBox(width: 5),
                                Text(_formatPeriod(routes[index].periodos)),
                              ],
                            ),
                          ],
                        ),
                        Text(_formatDate(routes[index].data)),
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
