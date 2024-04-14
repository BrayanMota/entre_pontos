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

            return ListView.builder(
              itemCount: routes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(routes[index].bairroPartida),
                  subtitle: Text(routes[index].bairroDestino),
                );
              },
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
}
