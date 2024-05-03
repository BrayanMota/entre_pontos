import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Perfil'),
        actions: [
          Image.asset(
            'assets/icons/logo.png',
          ),
          // Text('Ícone'),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text('Perfil'),
              const SizedBox(height: 20),
              const Text('Nome:'),
              const SizedBox(height: 20),
              const Text('Email:'),
              const SizedBox(height: 20),
              const Text('Telefone:'),
              const SizedBox(height: 20),
              const Text('Data de Nascimento:'),
              const SizedBox(height: 20),
              const Text('Sexo:'),
              const SizedBox(height: 20),
              const Text('Endereço:'),
              const SizedBox(height: 20),
              const Text('Cidade:'),
              const SizedBox(height: 20),
              const Text('Estado:'),
              const SizedBox(height: 20),
              const Text('País:'),
              const SizedBox(height: 20),
              const Text('CEP:'),
              const SizedBox(height: 20),
              const Text('Foto:'),
              const SizedBox(height: 20),
              const Text('Bio:'),
              const SizedBox(height: 20),
              const Text('Interesses:'),
              const SizedBox(height: 20),
              const Text('Pontos de Interesse:'),
              const SizedBox(height: 20),
              const Text('Matchings:'),
              const SizedBox(height: 20),
              const Text('Avaliações:'),
              const SizedBox(height: 20),
              const Text('Avaliação Média:'),
              const SizedBox(height: 20),
              const Text('Avaliações Positivas:'),
              const SizedBox(height: 20),
              const Text('Avaliações Negativas:'),
              const SizedBox(height: 20),
              const Text('Avaliações Neutras:'),
              const SizedBox(height: 20),
              const Text('Avaliações Recentes:'),
              const SizedBox(height: 20),
              const Text('Avaliações Antigas:'),
              const SizedBox(height: 20),
              const Text('Avaliações de Amigos:'),
              const SizedBox(height: 20),
              const Text('Avaliações de Amigos Recentes:'),
              const SizedBox(height: 20),
              const Text('Avaliações de Amigos Antigas:'),
              const SizedBox(height: 20),
              const Text('Avaliações de Amigos Positivas:'),
            ],
          ),
        ),
      ),
    );
  }
}
