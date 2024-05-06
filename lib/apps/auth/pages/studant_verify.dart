// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:entre_pontos/apps/user/model.dart';
import 'package:entre_pontos/apps/user/pages/tags.dart';

class VerifyPage extends StatefulWidget {
  UserModel user;
  VerifyPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: CardVerify(
          user: widget.user,
        ),
      ),
    );
  }
}

class CardVerify extends StatelessWidget {
  UserModel user;
  final TextEditingController _emailController = TextEditingController();

  CardVerify({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        // color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Verificação Estudantil',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              'Escolha como comprovar o seu vínculo estudantil:',
              style: TextStyle(
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'E-mail Institucional',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Card(
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                  ),
                ),
                Card(
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                  ),
                ),
                Card(
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Envio de documentos'),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TagsPage(
                          user: user,
                        ),
                      ),
                    );
                  },
                  child: const Text('Pular'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Verificar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
