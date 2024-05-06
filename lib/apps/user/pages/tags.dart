import 'package:entre_pontos/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:entre_pontos/apps/user/mock.dart';
import 'package:entre_pontos/apps/user/model.dart';
import 'package:entre_pontos/main.dart';

class TagsPage extends StatefulWidget {
  UserModel user;
  TagsPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<TagsPage> createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: ListTags(
          user: widget.user,
        ),
      ),
    );
  }
}

class ListTags extends StatefulWidget {
  UserModel user;

  ListTags({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ListTags> createState() => _ListTagsState();
}

class _ListTagsState extends State<ListTags> {
  final List _selectedTags = [];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        // color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Text(
              'Nos conte mais sobre você!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Escolha as tags que mais se encaixam com você:',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              'Escolha no mínimo 5 tags',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: tags.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ),
                itemBuilder: (context, index) {
                  final tag = tags[index];
                  return FilterChip(
                    selected: _selectedTags.contains(tag),
                    label: Text(tag),
                    onSelected: (bool value) {
                      setState(() {
                        if (value) {
                          _selectedTags.add(tag);
                        } else {
                          _selectedTags.remove(tag);
                        }
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_selectedTags.length < 5) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Selecione no mínimo 5 tags'),
                    ),
                  );
                } else {
                  _salvarCadastro();
                }
              },
              child: Text('${_selectedTags.length}/5 Finalizar'),
            ),
          ],
        ),
      ),
    );
  }

  void _salvarCadastro() {
    final AuthService authService = AuthService();
    UserModel user = UserModel(
      id: widget.user.id,
      nome: widget.user.nome,
      email: widget.user.email,
      senha: widget.user.senha,
      tags: _selectedTags.cast<String>(),
    );

    authService.register(user).then((String? erro) {
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RotePage(),
          ),
        );
      }
    });
  }
}
