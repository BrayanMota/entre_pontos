import 'package:entre_pontos/apps/meeting_point/pages/explore.dart';
import 'package:entre_pontos/apps/meeting_point/pages/list.dart';
import 'package:entre_pontos/custom/custom_drawer.dart';
import 'package:flutter/material.dart';

class MeetingPointPage extends StatefulWidget {
  const MeetingPointPage({super.key});

  @override
  State<MeetingPointPage> createState() => _MeetingPointPageState();
}

class _MeetingPointPageState extends State<MeetingPointPage>
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
          key: Key('MatchingPointDrawer'),
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
            // Navigator.pushNamed(context, '/meeting_point/create');
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
              text: 'Meus pontos de encontro',
            ),
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: const <Widget>[
            ExploreMeetingPointsPage(),
            MyMeetingPointsPage()
          ],
        ),
      ),
    );
  }
}
