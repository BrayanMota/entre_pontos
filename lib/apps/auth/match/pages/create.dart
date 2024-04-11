import 'package:flutter/material.dart';

import '../models.dart';

class RegisterMatchPage extends StatefulWidget {
  const RegisterMatchPage({super.key});

  @override
  State<RegisterMatchPage> createState() => _RegisterMatchPageState();
}

class _RegisterMatchPageState extends State<RegisterMatchPage> {
  TextEditingController diaController = TextEditingController();
  TextEditingController bairroPartidaController = TextEditingController();
  TextEditingController regiaoPartidaController = TextEditingController();
  TextEditingController bairroDestinoController = TextEditingController();
  TextEditingController regiaoDestinoController = TextEditingController();
  TextEditingController horarioChegadaController = TextEditingController();
  TextEditingController margemHorarioController = TextEditingController();

  bool? manhaChecked = true;
  bool? tardeChecked = true;
  bool? noiteChecked = true;
  bool? isRecorrente = false;

  static const List<String> items = [
    'Duque de Caxias',
    'Maricá',
    'Niteroi',
    'Nova Iguaçu',
    'Rio de Janeiro: Barra e Jacarepaguá',
    'Rio de Janeiro: Centro',
    'Rio de Janeiro: Grande Tijuca',
    'Rio de Janeiro: Grande Méier',
    'Rio de Janeiro: Ilha do Governador (UFRJ)',
    'Rio de Janeiro: Zona Sul',
    'Rio de Janeiro: Zona Norte',
    'Rio de Janeiro: Zona Oeste',
    'São João de Meriti',
    'São Gonçalo',
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: const Text('Adicionar Trajeto'),
          actions: [
            Image.asset(
              'assets/icons/logo.png',
            ),
          ],
        ),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Dia:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: '01/01/2001',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onTap: () => _selectData(context),
              controller: diaController,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: isRecorrente,
                  onChanged: (bool? value) {
                    setState(() {
                      isRecorrente = value;
                    });
                  },
                ),
                const Text(
                  'Recorrente',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Região de Partida:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DropdownButtonFormField<String>(
              isExpanded: true,
              hint: const Text('Selecione a região de partida'),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                regiaoPartidaController.text = value!;
              },
            ),
            InputLabel(
              label: 'Bairro de Partida',
              hintText: 'Digite o bairro de partida',
              controller: bairroPartidaController,
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Região de Destino:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DropdownButtonFormField<String>(
              isExpanded: true,
              hint: const Text('Selecione a região de destino'),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                regiaoDestinoController.text = value!;
              },
            ),
            InputLabel(
              label: 'Bairro de Destino',
              hintText: 'Digite o bairro de destino',
              controller: bairroDestinoController,
            ),
            Row(
              children: [
                Checkbox(
                  value: manhaChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      manhaChecked = value;
                    });
                  },
                ),
                const Text(
                  'Manhã',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Checkbox(
                  value: tardeChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      tardeChecked = value;
                    });
                  },
                ),
                const Text(
                  'Tarde',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Checkbox(
                  value: noiteChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      noiteChecked = value;
                    });
                  },
                ),
                const Text(
                  'Noite',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              child: const Text('Salvar'),
              onPressed: () {
                MatchModel match = MatchModel(
                  id: '1',
                  data: diaController.text,
                  recorrente: isRecorrente!,
                  regiaoPartida: items.indexOf(regiaoPartidaController.text),
                  bairroPartida: bairroPartidaController.text,
                  regiaoDestino: items.indexOf(regiaoDestinoController.text),
                  bairroDestino: bairroDestinoController.text,
                  periodos: [
                    if (manhaChecked!) 0,
                    if (tardeChecked!) 1,
                    if (noiteChecked!) 2,
                  ],
                  createdBy: '1',
                  createdAt: DateTime.now().toString(),
                  updatedAt: DateTime.now().toString(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectData(BuildContext context) async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (_picked != null) {
      String dataFormatada = "${_picked.day}/${_picked.month}/${_picked.year}";
      diaController.text = dataFormatada;
    }
  }
}

class InputLabel extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  String label;
  String hintText;

  InputLabel({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
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
              hintText: hintText,
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
