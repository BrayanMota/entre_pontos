import 'package:entre_pontos/apps/connection/models.dart';
import 'package:entre_pontos/custom/custom_drawer.dart';
import 'package:entre_pontos/services/auth_service.dart';
import 'package:entre_pontos/services/connection_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();
  final userID = ConnectionService().userID;

  final ConnectionService _connectionService = ConnectionService();

  int conexoes = 0;

  String nome = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    _auth.initialize();
    _auth.getUsuarioLogado().then((user) {
      if (user != null) {
        setState(() {
          nome = user.displayName!;
          email = user.email!;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
        key: const Key('HomeDrawer'),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Container(
          width: 130,
          height: 130,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(
                'https://avatars.githubusercontent.com/u/57840634?v=4',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                nome,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                email,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Check-in'),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Estudante da Instituição',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              _buildConnections(),
              const Divider(),
              const Text(
                  'Seja livre para colocar as coisas que você gosta. Mostre para os outros seus hobbies e se apresente'),
            ],
          ),
        ),
      ),
    );
  }

  StreamBuilder _buildConnections() {
    return StreamBuilder(
      stream: _connectionService.listConnections(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final docs = snapshot.data.docs;
          final conexoes = _rulesConnections(docs);
          return Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '$conexoes Conexões',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }

  // List<ConnectionModel> _rulesConnections(docs) {
  int _rulesConnections(docs) {
    List<ConnectionModel> connectionList = [];

    for (var item in docs) {
      final userID1 = item.data()['userID1'];
      final userID2 = item.data()['userID2'];
      if (userID1 == userID || userID2 == userID) {
        connectionList.add(ConnectionModel.fromJson(item.data()));
      }
    }
    return connectionList.length;
  }
}
