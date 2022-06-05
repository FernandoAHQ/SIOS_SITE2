import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:app/models/models.dart';
import 'package:app/providers/providers.dart';
import 'package:app/services/services.dart';
import 'package:app/theme/app_theme.dart';
import 'package:app/widgets/widgets.dart';

class DetailService extends StatelessWidget {
  const DetailService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

  final size = MediaQuery.of(context).size;
  final idreport = ModalRoute.of(context)!.settings.arguments.toString();
  final socketProv = Provider.of<SocketProvider>(context);
  final serviceProv = Provider.of<ServiceQuery>(context,listen: false);
  final feedbackProv = Provider.of<FeedBackProvider>(context,listen: false);

  // print(idreport);

    return FutureBuilder(
      future: serviceProv.getService(idreport),
      builder: (context, snapshot) {

        if ( !snapshot.hasData ) {
          return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
        }
        final Service service = snapshot.data as Service;
        
      var parsedDate = DateFormat('KK:mm').format(service.createdAt);

      return Scaffold(
          appBar: AppBar(
            backgroundColor: Apptheme.primarylight,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
            child: Column(
              children: [
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //* Severity Image

                    SeverityImage(size: size, severity: service.severity),
                    
                    SizedBox(
                      width: size.width*.5,
                      child: Column(
                        children: [
                          
                          //* Status Widget

                          StatusWidget(status: service.status),

                          //*Titulo del servicio 
          
                          Text(
                            service.report.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
          
                          //*Texto de Departamento 
                          
                          Text(
                            service.report.department.name,
                            textAlign: TextAlign.center,
                          ),
          
                          // * Texto de Hora
                          
                          Text(
                            parsedDate,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Apptheme.secondary,
                              fontSize: 12
                            ),
                          ),
          
                        ],
                      ),
                    )
          
                  ],
                ),
          
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          'Descripcion:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(service.report.description),
                        ),
                        // Row(
                        //   children: const[
                        //      Text(
                        //       'Categoria:',
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //         fontSize: 14
                        //       ),
                        //     ),
                        //     Text('Urgenteeeeee perrros correle',maxLines: 2,),
                        //   ],
                        // ),
                      ],
                    ) 
                    ),
                  )
                
                ),
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    
                    if (service.status == 'assigned')
                      CustomButton(
                        text: 'Iniciar',
                        feedbackProv: feedbackProv,
                        socketProv: socketProv,
                        service: service,
                        onPressed: (){
                          //* Funcion de boton iniciar servicio
                          // print('Iniciar');

                          socketProv.startService(
                            service.user!.id,
                            service.assignedTo.id,
                            service.id,
                          );

                        },
                      )

                    else if (service.status == 'in-progress')

                      CustomButton(
                        text: 'Finalizar',
                        feedbackProv: feedbackProv,
                        socketProv: socketProv,
                        service: service,
                        onPressed: () {
                          // print('Finalizarjiji');
                          feedbackProv.restartValues();
                          Navigator.pushNamed(context, 'feedback', arguments: service);
                        },

                      )

                  ],
                )
              
              ],
            ),
          ),

          
        );
      },
    );
 
    
  }

}

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.feedbackProv,
    required this.socketProv,
    required this.service,
    required this.text, 
    required this.onPressed,
  }) : super(key: key);

  final FeedBackProvider feedbackProv;
  final SocketProvider socketProv;
  final Service service;
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Apptheme.primarydark,
      child: Text(text,
      style: const TextStyle(
        color: Colors.white
      ),),
      onPressed: onPressed
    );
  }
}
