import 'package:entre_pontos/apps/auth/pages/login.dart';
import 'package:entre_pontos/pages/bottom_navigation.dart';
import 'package:entre_pontos/pages/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: const BottomNavigationPage(),
    );
  }
}
