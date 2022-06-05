import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/helpers/alerts.dart';
import 'package:app/providers/providers.dart';
import 'package:app/services/auth_service.dart';
import 'package:app/theme/app_theme.dart';
import 'package:app/widgets/widgets.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    

    return ChangeNotifierProvider(
      create: (_)=>LoginFormProvider(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
        child: _Form(),
      ),
    );
  }
}

class _Form extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final loginService = Provider.of<AuthService>(context);
    final loginProvider = Provider.of<LoginFormProvider>(context);
    
    return Form(
    
      key: loginProvider.formkey,
    
      child: Column(
        children: [
          
          CustomTextFormField(
            keyboardType: TextInputType.number,
            prefixIcon: Icons.person,
            hintText: 'Usuario',
            validator: (value) => value!.length == 8 ?'Usuario invalido': null,
            onChanged: (value) => loginProvider.ncontrol = value!,
          ),
    
          const SizedBox(height: 15,),
    
          CustomTextFormField(
            prefixIcon: Icons.lock,
            hintText: 'Contraseña',
            keyboardType: TextInputType.number,
            obscureText: true,
            validator: (value) => value!.isEmpty?'Contraseña':null,
            onChanged: (value) => loginProvider.password = value!,
          ),
    
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: (){},
                child:  const Text('¿Olvidaste tu contraseña?')
              )
            ],
          ),
    
          MaterialButton(
            elevation: 5,
            color: Apptheme.primarydark,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child:Container(
              padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 10),
              child: const Text('Iniciar Sesión',style: TextStyle(color: Apptheme.white,fontSize: 22),textAlign: TextAlign.center,)
            ),
            onPressed:
            () async {
    
              final isLogged = await loginService.login(loginProvider.ncontrol, loginProvider.password);
              
              if(isLogged == true){
                
                final socket = Provider.of<SocketProvider>(context, listen: false);
                socket.connect();
                Navigator.pushReplacementNamed(context, 'home');
                // Navigator.pushNamed(context, 'home');
    
              }else{
                mostrarAlerta(context, 'Error', 'Usuario o contraseña incorrectos');
              }
              
            }
    
          ),
    
          const SizedBox(height: 25,),

        ],
      )
    );
  }
}