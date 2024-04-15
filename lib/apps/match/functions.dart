import 'package:entre_pontos/apps/match/models.dart';

class RouteFuncionts {
  List<RouteModel> expandRoutes(List<RouteModel> routes) {
    List<RouteModel> expandedRoutes = [];
    for (RouteModel route in routes) {
      for (int periodo in route.periodos) {
        expandedRoutes.add(RouteModel(
          userID: route.userID,
          id: route.id,
          data: route.data,
          recorrente: route.recorrente,
          bairroDestino: route.bairroDestino,
          bairroPartida: route.bairroPartida,
          regiaoDestino: route.regiaoDestino,
          regiaoPartida: route.regiaoPartida,
          periodos: [periodo],
        ));
      }
    }
    return expandedRoutes;
  }

  Map<String, List<RouteModel>> groupRoutes(List<RouteModel> expandedRoutes) {
    Map<String, List<RouteModel>> tempGroupedRoutes = {};

    // Primeiro, agrupamos todos os RouteModels normalmente.
    for (RouteModel route in expandedRoutes) {
      String key =
          '${route.regiaoPartida}-${route.regiaoDestino}-${route.periodos.first}';
      tempGroupedRoutes.putIfAbsent(key, () => []);
      tempGroupedRoutes[key]!.add(route);
    }

    // Criamos um novo mapa para armazenar apenas os grupos com mais de uma conexão.
    Map<String, List<RouteModel>> filteredGroupedRoutes = {};

    // Filtramos o mapa temporário.
    tempGroupedRoutes.forEach((key, value) {
      if (value.length > 1) {
        filteredGroupedRoutes[key] = value;
      }
    });

    return filteredGroupedRoutes;
  }
}
