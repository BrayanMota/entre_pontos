import 'package:entre_pontos/apps/interest_point/pages/create.dart';
import 'package:entre_pontos/apps/interest_point/pages/explore.dart';
import 'package:entre_pontos/apps/interest_point/pages/list.dart';
import 'package:entre_pontos/custom/custom_drawer.dart';
import 'package:flutter/material.dart';

class InterestPointPage extends StatefulWidget {
  const InterestPointPage({super.key});

  @override
  State<InterestPointPage> createState() => _InterestPointPageState();
}

class _InterestPointPageState extends State<InterestPointPage>
    with TickerProviderStateMixin {
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
        drawer: const CustomDrawer(
          key: Key('InterestPointDrawer'),
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
                builder: (context) => const RegisterInterestPointPage(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'Explorar',
            ),
            Tab(
              text: 'Meus pontos de interesse',
            ),
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: const <Widget>[
            ExploreInterestPointsPage(),
            MyInterestPointsPage()
          ],
        ),
      ),
    );
  }
}
