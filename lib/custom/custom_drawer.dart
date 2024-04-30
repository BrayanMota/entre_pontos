import 'package:entre_pontos/apps/auth/pages/login.dart';
import 'package:entre_pontos/apps/match/pages/index.dart';
import 'package:entre_pontos/apps/meeting_point/pages/index.dart';
import 'package:entre_pontos/apps/users/pages/discover.dart';
import 'package:entre_pontos/pages/home.dart';
import 'package:entre_pontos/services/auth_service.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
              // width: 130,
              // height: 130,
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
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Página Inicial'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Matchings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MatchPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.place),
            title: const Text('Pontos de Encontro'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MeetingPointPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Descobrir'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DiscoverUsersPage(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Sair'),
            leading: const Icon(Icons.exit_to_app),
            iconColor: Colors.red,
            textColor: Colors.red,
            onTap: () {
              AuthService().logout();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                  (route) => false);
              // Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
