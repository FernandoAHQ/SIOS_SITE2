import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app/providers/providers.dart';
import 'package:app/screens/screens.dart';
import 'package:app/services/auth_service.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

   
  @override
  Widget build(BuildContext context) {


    final loginService = Provider.of<AuthService>(context, listen: false);
    final socketprov = Provider.of<SocketProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xff3366ff),
      // body: LoadingWidget(),
      body: FutureBuilder(
        future: loginService.verifyToken(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {

          if ( !snapshot.hasData ) {
            return const LoadingWidget();
          }

          if ( snapshot.data == false){

            Future.microtask(() {

              Navigator.pushReplacement(context, PageRouteBuilder(
              pageBuilder: (_,__,___) => const LoginScreen(),
              transitionDuration: const Duration( seconds: 0)
              )
              );
              
            });

          }
          else{

            Future.microtask(() {

              socketprov.connect();
              Navigator.pushReplacement(context, PageRouteBuilder(
              pageBuilder: (_,__,___) => const HomeScreen(),
              transitionDuration: const Duration( seconds: 0)
              )
              );
              
            });

          }
          
          return Container();

        },
      ), 
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Center(

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [

            Image(
              image: const AssetImage('assets/sioslogo.png'),
              height: size.height* 0.3,
            ),

            const CircularProgressIndicator(color: Color(0xffd2d2d2),),
            
          ],

        ),

      ),

    );
  }
}
