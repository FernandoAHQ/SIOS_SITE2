import 'package:app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app/models/log_response.dart';

class LogService extends ChangeNotifier{

  late LogResponse logResponse;

  Future getLog() async{
    final jsonData = await http.get(Uri.parse('http://10.1.41.40:4000/api/services/bitacora?page=1'));
    return logResponse = LogResponse.fromJson(jsonData.body);
  }


  
  Future getLogSearch(String query) async{
    final jsonData = await http.get(Uri.parse('http://10.1.41.40:4000/api/search/$query'));
    return logResponse = LogResponse.fromJson(jsonData.body);
  }
  
}