import 'package:app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app/models/log_response.dart';

class LogService extends ChangeNotifier{

  late LogResponse logResponse;

  Future getLog() async{
    final jsonData = await http.get(Uri.parse('https://sios-server.herokuapp.com/api/services/bitacora?page=1'));
    return logResponse = LogResponse.fromJson(jsonData.body);
  }

  
  Future getLogSearch(String query) async{
    final jsonData = await http.get(Uri.parse('https://sios-server.herokuapp.com/api/search/$query'));
    return logResponse = LogResponse.fromJson(jsonData.body);
  }
  
}