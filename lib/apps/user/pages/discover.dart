import 'package:entre_pontos/apps/user/model.dart';
import 'package:entre_pontos/custom/custom_drawer.dart';
import 'package:entre_pontos/services/user_service.dart';
import 'package:flutter/material.dart';

class DiscoverUsersPage extends StatefulWidget {
  const DiscoverUsersPage({super.key});

  @override
  State<DiscoverUsersPage> createState() => _DiscoverUsersPageState();
}

class _DiscoverUsersPageState extends State<DiscoverUsersPage>
    with TickerProviderStateMixin {
  final UserService _userService = UserService();

  final TextEditingController searchController = TextEditingController();
  List<UserModel> users = <UserModel>[];
  List<UserModel> usersFiltered = <UserModel>[];

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          drawer: const CustomDrawer(
            key: Key('DiscoverDrawer'),
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
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Center(
              child: Column(
                children: [
                  TextField(
                    controller: searchController,
                    onChanged: _searchUsers,
                    decoration: InputDecoration(
                      hintText: 'Pesquisar',
                      suffixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // _buildStreamBuilder(),
                  _buildListView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStreamBuilder() {
    return StreamBuilder(
      stream: _userService.listUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data!.docs.isNotEmpty) {
          for (var item in snapshot.data!.docs) {
            users.add(UserModel.fromJson(item.data()));
          }

          return Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: users.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png',
                        ),
                      ),
                      title: Text(users[index].nome),
                      isThreeLine: true,
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(users[index].email),
                          Text(users[index].tags.join(', ')),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(
            child: Text(
              'Nenhum registro encontrado',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildListView() {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: usersFiltered.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png',
                  ),
                ),
                title: Text(usersFiltered[index].nome),
                isThreeLine: true,
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(usersFiltered[index].email),
                    Text(usersFiltered[index].tags.join(', ')),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _searchUsers(String query) {
    if (query.isEmpty) {
      usersFiltered = users;
      setState(() {});
      return;
    }

    usersFiltered = users.where((element) {
      // Verifica se o nome ou o email do usuário contém o texto de pesquisa
      bool nameContains =
          element.nome.toLowerCase().contains(query.toLowerCase());
      bool emailContains =
          element.email.toLowerCase().contains(query.toLowerCase());

      // Verifica se alguma das tags do usuário contém o texto de pesquisa
      bool tagContains = element.tags
          .any((tag) => tag.toLowerCase().contains(query.toLowerCase()));

      // Retorna true se qualquer um dos critérios de filtro for verdadeiro
      return nameContains || emailContains || tagContains;
    }).toList();
    setState(() {});
  }

  void _loadData() {
    _userService.listUsers().listen((event) {
      users = event.docs.map((e) => UserModel.fromJson(e.data())).toList();
      setState(() {
        usersFiltered = users;
      });
    });
  }
}
