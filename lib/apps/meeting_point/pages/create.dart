import 'package:entre_pontos/apps/meeting_point/model.dart';
import 'package:entre_pontos/services/_point_service.dart';
import 'package:entre_pontos/utils/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class RegisterMeetingPointPage extends StatefulWidget {
  const RegisterMeetingPointPage({super.key});

  @override
  State<RegisterMeetingPointPage> createState() =>
      _RegisterMeetingPointPageState();
}

class _RegisterMeetingPointPageState extends State<RegisterMeetingPointPage> {
  final _formKey = GlobalKey<FormState>();

  String _dataDesfomatada = '';
  final TextEditingController _diaController = TextEditingController();
  final TextEditingController _partidaController = TextEditingController();
  final TextEditingController _destinoController = TextEditingController();
  final TextEditingController _horarioChegadaController =
      TextEditingController();

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
          title: const Text(
            'Ponto de Encontro',
            style: TextStyle(
                // fontSize: 16,
                // fontWeight: FontWeight.bold,
                ),
          ),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Dia:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
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
              const Text(
                'Hora:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: '00:00',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onTap: () => _selectTime(context),
                controller: _horarioChegadaController,
                validator: CustomValidators.validarCampoObrigatorio,
              ),
              const SizedBox(height: 10),
              InputLabel(
                label: 'Local de Partida',
                hintText: 'Informe o local de partida',
                controller: _partidaController,
              ),
              InputLabel(
                label: 'Local de Destino',
                hintText: 'Informe o local de destino',
                controller: _destinoController,
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  child: const Text('Salvar'),
                  onPressed: () {
                    _validarFormulario();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validarFormulario() {
    if (_formKey.currentState!.validate()) {
      _salvarFormulario();
    }
  }

  void _salvarFormulario() {
    MeetingPointModel meetingPoint = MeetingPointModel(
      userID: FirebaseAuth.instance.currentUser!.uid,
      id: const Uuid().v1(),
      data: DateTime.parse(_dataDesfomatada),
      hora: _horarioChegadaController.text,
      partida: _partidaController.text,
      chegada: _destinoController.text,
      users: [
        FirebaseAuth.instance.currentUser!.uid,
      ],
    );

    MeetingPointService().createMeetingPoint(meetingPoint).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ponto de encontro cadastrado com sucesso!'),
        ),
      );
      Navigator.pop(context);
    });
  }

  Future<void> _selectTime(BuildContext context) async {
    // Obtendo a hora atual ajustada para o fuso horário de Palmas (GMT-3)
    DateTime fuso = DateTime.now().toUtc().subtract(const Duration(hours: 3));
    TimeOfDay initialTime = TimeOfDay(hour: fuso.hour, minute: fuso.minute);

    final TimeOfDay? _picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (_picked != null) {
      String horaFormatada = "${_picked.hour}:${_picked.minute}";
      _horarioChegadaController.text = horaFormatada;
    }
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
