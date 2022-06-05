import 'package:flutter/material.dart';
import 'package:app/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {

  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: _LoginStructure(),
      ),
    );
  }
}

class _LoginStructure extends StatelessWidget {
  const _LoginStructure({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Column(
        children: [

          const SizedBox(height: 50,),

          Image.asset('assets/sioslogo.png',height: size.height * 0.3 ,),

          const Text('Bienvenido',style: TextStyle(fontSize: 30),),
          const Text('Inicia sesión para continuar',style: TextStyle(fontSize: 20,color: Color(0xff848484)),),

          const LoginForm(),

        ],
      ),
    );
  }
}
