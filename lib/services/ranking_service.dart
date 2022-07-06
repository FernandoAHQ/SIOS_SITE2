import 'dart:convert';

import 'package:app/models/models.dart';
import 'package:app/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app/models/periods.dart';

class RankingService extends ChangeNotifier{


  Future<Period> getRanking() async{
    final jsonData = await http.get(Uri.parse(serverUrl + '/api/periods/active'));
    print(jsonData.body);
    return Period.fromJson(jsonData.body);
  }

 
  
}