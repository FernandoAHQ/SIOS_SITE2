import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app/models/models.dart';

class UsersSiteProvider extends ChangeNotifier{

 SiteUsers usuariosSite = SiteUsers(status: false, users:[]);

  Future getSiteUsers() async {

    final resp = await http.get(Uri.parse('10.1.41.40:4000/api/users/all/active'));
    // final resp = await http.get(Uri.parse('http://10.1.25.40:4000/api/users/all/active'));
    if (resp.statusCode == 200) {
      usuariosSite = siteUsersFromJson(resp.body);

      return usuariosSite.users;
    }
    
  }
  
}