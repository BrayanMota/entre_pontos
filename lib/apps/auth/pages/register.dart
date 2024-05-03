import 'package:entre_pontos/apps/auth/pages/login.dart';
import 'package:entre_pontos/services/auth_service.dart';
import 'package:entre_pontos/utils/validators.dart';
import 'package:flutter/material.dart';

import 'verify.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: CardRegister(),
      ),
    );
  }
}

class CardRegister extends StatelessWidget {
  // TextEditingController _dateController = TextEditingController();
  // TextEditingController _instituicaoController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  final AuthService _authService = AuthService();

  final _formKey = GlobalKey<FormState>();

  static const List<String> items = ['UFRJ', 'UFF', 'USP'];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        // color: Colors.blue,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Cadastro',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome Completo',
                  border: OutlineInputBorder(),
                ),
                validator: CustomValidators.validarCampoObrigatorio,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
                validator: CustomValidators.validarEmail,
              ),
              // TextField(
              //   decoration: InputDecoration(
              //     labelText: 'Data de Nascimento',
              //     border: OutlineInputBorder(),
              //   ),
              //   onTap: () => _selectData(context),
              //   controller: _dateController,
              // ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _senhaController,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: CustomValidators.validarCampoObrigatorio,
              ),
              // DropdownButtonFormField<String>(
              //   decoration: InputDecoration(
              //     labelText: 'Instituição',
              //     border: OutlineInputBorder(),
              //   ),
              //   items: items.map((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              //   onChanged: (String? value) {},
              // ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Voltar',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => VerifyPage(),
                      //   ),
                      // );
                      _validarCampos(context);
                    },
                    child: const Text(
                      // 'Continuar',
                      'Cadastrar',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validarCampos(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _salvarCadastro(context);
    }
  }

  void _salvarCadastro(BuildContext context) {
    String nome = _nomeController.text;
    String email = _emailController.text;
    String senha = _senhaController.text;

    _authService.criarUsuario(nome, email, senha).then((String? erro) {
      if (erro != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(erro),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Usuário criado com sucesso'),
          ),
        );
        const Duration(seconds: 2);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      }
    });
  }

  // Future<void> _selectData(BuildContext context) async {
  //   DateTime? _picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2100),
  //   );

  //   if (_picked != null) {
  //     String dataFormatada = "${_picked.day}/${_picked.month}/${_picked.year}";
  //     _dateController.text = dataFormatada;
  //   }
  // }
}
