import 'package:flutter/material.dart';

class RegisterMatchPage extends StatefulWidget {
  const RegisterMatchPage({super.key});

  @override
  State<RegisterMatchPage> createState() => _RegisterMatchPageState();
}

class _RegisterMatchPageState extends State<RegisterMatchPage> {
  TextEditingController diaController = TextEditingController();
  TextEditingController bairroPartidaController = TextEditingController();
  TextEditingController bairroDestinoController = TextEditingController();
  TextEditingController horarioChegadaController = TextEditingController();
  TextEditingController margemHorarioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text('Adicionar Trajeto'),
        actions: const [
          // Image.asset(
          //   'assets/icons/icon.png',
          // )
          Text('Ícone'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InputLabel(
              label: 'Dia',
              controller: diaController,
            ),
            InputLabel(
              label: 'Bairro de Partida',
              controller: bairroPartidaController,
            ),
            InputLabel(
              label: 'Bairro de Destino',
              controller: bairroDestinoController,
            ),
            InputLabel(
              label: 'Horário ideal de chegada',
              controller: horarioChegadaController,
            ),
            InputLabel(
              label: 'Margem de horário',
              controller: margemHorarioController,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}

class InputLabel extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  String label;

  InputLabel({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
