import 'package:app/services/ranking_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/providers/providers.dart';
import 'package:intl/intl.dart';
import 'package:app/widgets/widgets.dart';

import '../../models/periods.dart';


class TodayView extends StatelessWidget {
  const TodayView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    
   
    final socketprov = Provider.of<SocketProvider>(context);

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: socketprov.services.length,
      itemBuilder: (_,int index) => _ReportCard(service: socketprov.services[index],)
    );
  }
}

class _ReportCard extends StatelessWidget {

  final dynamic service;

  const _ReportCard({
    this.service
  });

  @override
  Widget build(BuildContext context) {

    var parsedDate = DateFormat('KK:mm').format(DateTime.parse(service['report']['createdAt']));

    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'details',arguments: service['_id']),
      child: Container(
        height: size.height*.15,
        padding: const EdgeInsets.all(10),
    
        child: Row(
          children: [
    
            SeverityImage(size: size, severity: service['severity']),
            
            SizedBox(
               width: size.width*0.45,
              child: Column(
                mainAxisAlignment:MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
    
                  Text(service['report']['title'],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12
                  ),),
    
                  Text(service['report']['department']['name'],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12
                  ),),
                  
                  Text(
                  parsedDate.toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                    color: Color(0xFF787878),
                    fontWeight: FontWeight.bold,
                    fontSize: 11
                  ),)
                  
                ],
              ),
            ),
    
            Expanded(
              child: StatusWidget(status: service['status']),
            )
    
          ],
        ),
        
      ),
    );
  }

}