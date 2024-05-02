import 'package:entre_pontos/apps/users/model.dart';
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

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
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
                  decoration: InputDecoration(
                    hintText: 'Pesquisar',
                    suffixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                StreamBuilder(
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
                      List<UserModal> users = [];

                      for (var item in snapshot.data!.docs) {
                        users.add(UserModal.fromJson(item.data()));
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
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      // users[index].foto,
                                      'https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png',
                                    ),
                                  ),
                                  title: Text(users[index].nome),
                                  subtitle: Text(users[index].email),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
