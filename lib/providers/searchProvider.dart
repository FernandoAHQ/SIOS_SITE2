import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class LogSearchProvider extends ChangeNotifier{


  String query = '';
 SearchLogResponse bitacora = SearchLogResponse(status: false, bitacora: []);

  Future getBitacora() async {
    print("HEY");

    final resp = await http.get(Uri.parse('10.1.41.40:4000/api/search/$query'));
    // final resp = await http.get(Uri.parse('http://10.1.25.40:4000/api/users/all/active'));
    if (resp.statusCode == 200) {
      bitacora = SearchLogResponse.fromJson(resp.body);
    //  print(bitacora.bitacora[0].description);
      return bitacora;
    }
    notifyListeners();
  }



  setQuery(String q){
    query = q;
    notifyListeners();
  }

  printData(){
  }

}