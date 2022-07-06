import 'package:app/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app/providers/providers.dart';
import 'package:app/services/auth_service.dart';
import 'package:app/theme/app_theme.dart';

import 'home_screen_view/history_view.dart';
import 'home_screen_view/today_view.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key, required this.socketprov, required this.loginService}) : super(key: key); 

  final SocketProvider socketprov; 
  final AuthService loginService;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          ListTile(
            onTap: () => Navigator.pushNamed(context, 'ranking'),
            leading: const Icon(Icons.flag),
            title: const Text('Ranking'),
          ),
          const Divider(),
          ListTile(
            onTap: () => {
              context.read<LogSearchProvider>().setQuery(''),
              Navigator.pushNamed(context, 'log')
            },
            leading: const Icon(Icons.book),
            title: const Text('Bitacora de Servicios'),
          ),
          const Divider(),
          // ListTile(
          //   onTap: () => Navigator.pushNamed(context, 'ratings'),
          //   leading: const Icon(Icons.thumb_up),
          //   title: const Text('Mis Calificaciones'),
          // ),
          Expanded(child: Container(),),
          ListTile(
            onTap: () async {
            socketprov.disconnect();
            await loginService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
            leading: const Icon(Icons.logout),
            title: const Text('Cerrar Sesión'),
          )
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final loginService = Provider.of<AuthService>(context, listen: false);
    final user = loginService.user;

    final socketprov = Provider.of<SocketProvider>(context);

    return Scaffold(
      backgroundColor: Apptheme.primarylight,
      drawer: Drawer(
        child: DrawerMenu(socketprov: socketprov, loginService: loginService,),
        shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(15))),
      ),
      appBar: AppBar(
        backgroundColor: Apptheme.primarylight,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: size.height * .15,
            decoration: const BoxDecoration(
              color: Apptheme.primarylight,
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * .02),
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(100)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: FadeInImage(
                          height: size.height * .08,
                          width: size.height * .08,
                          fit: BoxFit.cover,
                          placeholder: const AssetImage('assets/loading.gif'),
                          image: NetworkImage(imgUserURL+ user.image)),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hola',
                      style: TextStyle(color: Apptheme.white, fontSize: 16),
                    ),
                    Text(
                      user.name,
                      style: const TextStyle(
                          color: Apptheme.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Apptheme.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              width: size.width,
              child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: const [
                      TabBar(
                        tabs: [
                          Tab(
                            child: Text(
                              'Hoy',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Historial',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                          child: TabBarView(
                        children: [
                          TodayView(),
                          HistoryView(),
                        ],
                      ))
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}