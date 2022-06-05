import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier{
  
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String ncontrol = '' ;
  String password = '';

  bool isValidForm (){
   return formkey.currentState?.validate() ?? false;
  }

}