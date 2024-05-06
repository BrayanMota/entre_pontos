import 'package:entre_pontos/apps/auth/pages/studant_verify.dart';
import 'package:entre_pontos/apps/user/model.dart';
import 'package:entre_pontos/services/auth_service.dart';
import 'package:entre_pontos/utils/validators.dart';
import 'package:flutter/material.dart';

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
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  final AuthService _authService = AuthService();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                decoration: InputDecoration(
                  labelText: 'Nome Completo',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: CustomValidators.validarCampoObrigatorio,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: CustomValidators.validarEmail,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _senhaController,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
                validator: CustomValidators.validarSenha,
              ),
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
                      _validarCampos(context);
                    },
                    child: const Text(
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
    UserModel user = UserModel(
      id: '',
      nome: _nomeController.text,
      email: _emailController.text,
      senha: _senhaController.text,
      tags: [],
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerifyPage(
          user: user,
        ),
      ),
    );
  }
}
