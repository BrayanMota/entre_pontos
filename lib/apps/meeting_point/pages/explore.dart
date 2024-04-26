import 'package:flutter/material.dart';

class ExploreMeetingPointsPage extends StatefulWidget {
  const ExploreMeetingPointsPage({super.key});

  @override
  State<ExploreMeetingPointsPage> createState() =>
      _ExploreMeetingPointsPageState();
}

class _ExploreMeetingPointsPageState extends State<ExploreMeetingPointsPage> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CardMeetingPoint(
          partida: 'CT',
          chegada: 'UFRJ',
          periodo: 'Manhã',
          quantidade: 2,
        ),
        CardMeetingPoint(
          partida: 'CCMN',
          chegada: 'UFRJ',
          periodo: 'Tarde',
          quantidade: 3,
        ),
        CardMeetingPoint(
          partida: 'Piratininga',
          chegada: 'Níteroi',
          periodo: 'Noite',
          quantidade: 4,
        ),
      ],
    );
  }
}

class CardMeetingPoint extends StatelessWidget {
  final String partida;
  final String chegada;
  final String periodo;
  final int quantidade;

  const CardMeetingPoint({
    required this.partida,
    required this.chegada,
    required this.periodo,
    required this.quantidade,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(vertical: 10, horizontal: 20), // Cards
      child: Container(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$partida - $chegada',
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  periodo,
                  style: const TextStyle(fontSize: 18.0),
                ),
              ],
            ),
            // ListView.builder(
            //   physics: const NeverScrollableScrollPhysics(),
            //   itemCount: quantidade,
            //   itemBuilder: (context, index) {
            //     return const Icon(
            //       Icons.person,
            //       size: 30,
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
