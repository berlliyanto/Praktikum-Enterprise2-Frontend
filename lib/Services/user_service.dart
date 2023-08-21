import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_user_interface/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future getUser() async {
    Uri url = Uri.parse("http://172.20.10.7:80/ENA2/user.php");
    var response = await http.get(url,
        headers: <String, String>{'Content-Type': 'application/json'});
    Iterable it = (json.decode(response.body) as Map<String, dynamic>)['data'];
    List<userModel> getUser = it.map((e) => userModel.FromJSON(e)).toList();
    return getUser;
  }
}

class UpdateUserService {
  static Future<UpdateUserService> updateUser(int id, String username,
      String password, String nama, String level) async {
    Uri url = Uri.parse("http://172.20.10.7:80/ENA2/user.php");
    var response = await http.put(
      url,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          "iduser": id.toString(),
          "username": username,
          "password": password,
          "nama": nama,
          "level": level
        },
      ),
    );
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("OK");
      }
    }
    return UpdateUserService();
  }
}

class DeleteUserService {
  static Future deleteUser(int id) async {
    Uri url = Uri.parse("http://172.20.10.7:80/ENA2/user.php");
    try {
      var response = await http.delete(
        url,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(
          {"iduser": id.toString()},
        ),
      );
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("OK");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

class InsertUserService {
  static Future insertUser(
      String username, String password, String level, String nama) async {
    Uri url = Uri.parse("http://172.20.10.7:80/ENA2/register.php");
    try {
      var response = await http.post(
        url,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(
          {
            "username": username,
            "password": password,
            "level": level,
            "nama": nama,
          },
        ),
      );
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("OK");
          return true;
        }
      }else {
        return false;
      }
      
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
