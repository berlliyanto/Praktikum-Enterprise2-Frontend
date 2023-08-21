import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as universal_html;

class User {
  final String name;
  final String email;

  User(this.name, this.email);
}

class LoginService {
  Future login(String username, String password) async {
    Uri url = Uri.parse("http://172.20.10.7:80/ENA2/login.php");
    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
          {'username': username, 'password': password},
        ),
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return data;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
  Future loginData(String username)async{
    Uri url = Uri.parse("http://172.20.10.7:80/ENA2/savedatalogin.php");
    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
          {'username': username},
        ),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

}
