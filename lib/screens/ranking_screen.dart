import 'package:app/providers/providers.dart';
import 'package:app/services/constants.dart';
import 'package:app/services/ranking_service.dart';
import 'package:flutter/material.dart';
import 'package:app/theme/app_theme.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../models/periods.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final prov = Provider.of<RankingService>(context);

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: const Text('Ranking'),
          backgroundColor: Apptheme.primarylight),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
        future: prov.getRanking(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Expanded(child: Center(child: CircularProgressIndicator(),));
          }
          Period periodo = snapshot.data as Period;
          List<Ranked> users = periodo.ranking;

          return  Column(
          children: [
            SizedBox(
              height: size.height * 0.33,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _TopUser(size: size,porcentaje: 23, user: users[1]),
                  _TopUser(size: size,porcentaje: 28, user: users[0]),
                  _TopUser(size: size,porcentaje: 18, user: users[3]),
                ],
              ),
            ),
             _UserList(listUsers: users,)
          ],
        );
        }
        
    ),
      ));
  }
}

class _TopUser extends StatelessWidget {
  const _TopUser({
    Key? key,
    required this.user,
    required this.size,
    required this.porcentaje,
  }) : super(key: key);

  final Size size;
  final int porcentaje;
  final Ranked user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (size.width) * .25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            
            borderRadius: BorderRadius.circular(100),
            child: Container(
              width: size.width * (porcentaje * .01),
              child: Image(
                  fit: BoxFit.cover,
                  image:  NetworkImage(
                      imgUserURL + user.image)),
            ),
          ),
           Text(
            user.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
                 Text(
            user.points.toString() + ' puntos',
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}

class _UserList extends StatelessWidget {
   _UserList({required this.listUsers});

  final List<Ranked> listUsers;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox(
      child: ListView.separated(
        itemCount: listUsers.length - 3,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 30,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child:  Image(
                  image: NetworkImage(imgUserURL + listUsers[index + 3].image),
                  fit: BoxFit.cover,
                )),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                  listUsers[index + 3].name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                
                            ),
                ),
                Text('No. ' + (index + 3).toString()),
              ],
            ),
            trailing:  Text('${listUsers[index + 3].points} puntos'),
          );
        },
      ),
    ));
  }
}
