import 'package:flutter/material.dart';
import 'package:flutter_user_interface/constant.dart';
import 'package:flutter_user_interface/dashboard.dart';
import 'package:flutter_user_interface/login.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case myLogin:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      case myDashboard:
        return MaterialPageRoute(builder: (context) => dashboard(name: "",level: "",));
      default:
    }
    return MaterialPageRoute(
      builder: ((context) {
        return const Scaffold(
          body: Center(
            child: Text("No Pages"),
          ),
        );
      }),
    );
  }
}
