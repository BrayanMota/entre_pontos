import 'package:flutter/material.dart';

import 'home.dart';
import '../apps/auth/match/pages/list.dart';
import 'settings.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _selectedIndex = 1;

  final _pages = <Widget>[
    SettingsPage(),
    HomePage(),
    MatchPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Matchs',
          ),
        ],
        currentIndex: 1,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        onTap: _onItemTapped,
      ),
    );
  }
}
