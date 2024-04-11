import 'package:flutter/material.dart';

import 'create.dart';

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
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        centerTitle: true,
        actions: [
          Image.asset(
            'assets/icons/logo.png',
          ),
          // Text('Ícone'),
        ],
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
        children: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterMatchPage(),
                ),
              );
            },
            child: Text('Adicionar Trajeto'),
          ),
          Center(
            child: Text("Primeiro, adicione um trajeto"),
          ),
        ],
      ),
    );
  }
}


