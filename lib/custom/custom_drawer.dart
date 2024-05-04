import 'package:entre_pontos/apps/auth/pages/login.dart';
import 'package:entre_pontos/apps/match/pages/index.dart';
import 'package:entre_pontos/apps/interest_point/pages/index.dart';
import 'package:entre_pontos/apps/user/pages/discover.dart';
import 'package:entre_pontos/apps/user/pages/profile.dart';
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
                  image: AssetImage(
                    'assets/icons/logo.png',
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
            title: const Text('Pontos de Interesse'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InterestPointPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.place),
            title: const Text('Trajetos'),
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
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('Chat'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notificações'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
          ),
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
