import 'package:app/models/log_response.dart';
import 'package:flutter/material.dart';

import '../models/service.dart';
import '../theme/app_theme.dart';

class ViewLog extends StatelessWidget {

  Bitacora service;
  
   ViewLog({required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        elevation: 0,
        title: const Text('Bitacora'),
        backgroundColor: Apptheme.primarylight,
      ),
      body: Container(
      padding: const EdgeInsets.all(20.0),
      child: 
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: const [
                  Icon(Icons.history, size: 42.0, color: Color.fromARGB(255, 0, 55, 100),),
                  SizedBox(width: 15.0,),
              Text("BITACORA", style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 55, 100)),),
      
            ],
          ),
        
        const SizedBox(height: 32.0,),


          const Text("Descripción del Problema", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 55, 100)),),
          Text(service.description, style: const TextStyle(fontSize: 20.0,),),
          const SizedBox(height: 20.0,),
          const Text("Solución", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 55, 100)),),
          Text(service.solution, style: const TextStyle(fontSize: 20.0,),),
          const SizedBox(height: 20.0,),
        ],
      ),
    ),
    );
  }
}