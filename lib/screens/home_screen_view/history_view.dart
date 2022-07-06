import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:app/models/models.dart';
import 'package:app/services/services.dart';
import 'package:app/widgets/widgets.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final historyProvider = Provider.of<ServiceQuery>(context);

    return FutureBuilder(
      future: historyProvider.getHistory(),
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final historyList = snapshot.data as List<Service>;
        return ListView.builder(
          itemCount: historyList.length,
          itemBuilder: (_, int index) => _HistoryCard(historyList[index]),
          physics: const BouncingScrollPhysics(),
        );
      },
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard(this.service);

  final Service service;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var parsedDate = DateFormat('KK:mm:ss').format(service.createdAt);

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'details', arguments: service.id),
      child: Container(
        height: size.height * .15,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            SeverityImage(size: size, severity: service.severity),
            SizedBox(
              width: size.width * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.report.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  Text(
                    service.report.department.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                  ),
                  Text(
                    parsedDate,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Color(0xFF787878),
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                // child: Text('En proceso',textAlign: TextAlign.center,),
                child: StatusWidget(status: service.status))
          ],
        ),
      ),
    );
  }
}
