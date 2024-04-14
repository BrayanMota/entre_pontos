import 'package:entre_pontos/apps/match/pages/create.dart';
import 'package:entre_pontos/apps/match/pages/matchs.dart';
import 'package:entre_pontos/apps/match/pages/routes.dart';
import 'package:entre_pontos/custom/custom_drawer.dart';
import 'package:flutter/material.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({super.key});

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      child: Scaffold(
        drawer: CustomDrawer(
          key: const Key('HomeDrawer'),
        ),
        appBar: AppBar(
          centerTitle: true,
          actions: [
            Image.asset(
              'assets/icons/logo.png',
            ),
            // Text('Ícone'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RegisterMatchPage(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'Trajetos',
            ),
            Tab(
              text: 'Matchings',
            ),
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: const <Widget>[
            ListRoutes(),
            ListMatchs(),
          ],
        ),
      ),
    );
  }
}
