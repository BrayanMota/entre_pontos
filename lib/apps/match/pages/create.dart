import 'package:entre_pontos/services/route_service.dart';
import 'package:entre_pontos/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models.dart';

class RegisterMatchPage extends StatefulWidget {
  const RegisterMatchPage({super.key});

  @override
  State<RegisterMatchPage> createState() => _RegisterMatchPageState();
}

class _RegisterMatchPageState extends State<RegisterMatchPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _diaController = TextEditingController();
  String _dataDesfomatada = '';
  TextEditingController _bairroPartidaController = TextEditingController();
  TextEditingController _regiaoPartidaController = TextEditingController();
  TextEditingController _bairroDestinoController = TextEditingController();
  TextEditingController _regiaoDestinoController = TextEditingController();
  TextEditingController _horarioChegadaController = TextEditingController();
  TextEditingController _margemHorarioController = TextEditingController();

  bool? manhaChecked = false;
  bool? tardeChecked = false;
  bool? noiteChecked = false;
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
        child: Form(
          key: _formKey,
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
              TextFormField(
                decoration: InputDecoration(
                  hintText: '01/01/2001',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onTap: () => _selectData(context),
                controller: _diaController,
                validator: CustomValidators.validarCampoObrigatorio,
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
                  _regiaoPartidaController.text = value!;
                },
                validator: CustomValidators.validarCampoObrigatorio,
              ),
              InputLabel(
                label: 'Bairro de Partida',
                hintText: 'Digite o bairro de partida',
                controller: _bairroPartidaController,
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
                  _regiaoDestinoController.text = value!;
                },
                validator: CustomValidators.validarCampoObrigatorio,
              ),
              InputLabel(
                label: 'Bairro de Destino',
                hintText: 'Digite o bairro de destino',
                controller: _bairroDestinoController,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Períodos:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                  _validarFormulario();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validarFormulario() {
    if (_formKey.currentState!.validate()) {
      if (manhaChecked == false &&
          tardeChecked == false &&
          noiteChecked == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Selecione pelo menos um período'),
          ),
        );
        return;
      }
      _salvarFormulario();
    }
  }

  void _salvarFormulario() {
    RouteModel match = RouteModel(
      id: const Uuid().v1(),
      data: DateTime.parse(_dataDesfomatada),
      recorrente: isRecorrente!,
      regiaoPartida: items.indexOf(_regiaoPartidaController.text),
      bairroPartida: _bairroPartidaController.text,
      regiaoDestino: items.indexOf(_regiaoDestinoController.text),
      bairroDestino: _bairroDestinoController.text,
      periodos: [
        if (manhaChecked!) 0,
        if (tardeChecked!) 1,
        if (noiteChecked!) 2,
      ],
    );
    RouteService().createRoute(match).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Trajeto cadastrado com sucesso!'),
        ),
      );
      Navigator.pop(context);
    });
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
      _dataDesfomatada = _picked.toString();
      _diaController.text = dataFormatada;
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
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: CustomValidators.validarCampoObrigatorio,
          ),
        ],
      ),
    );
  }
}
