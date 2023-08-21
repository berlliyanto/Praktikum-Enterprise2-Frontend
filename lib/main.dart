import 'package:flutter/material.dart';
import 'package:flutter_user_interface/constant.dart';
import 'package:flutter_user_interface/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Roboto'
      ),
      debugShowCheckedModeBanner: false,
      title: 'LOGIN',
      onGenerateRoute: Routes.generateRoute,
      initialRoute: myLogin,
    );
  }
}

// Widget build(BuildContext context) => MaterialApp.router(
//         routerDelegate: _router.routerDelegate,
//         routeInformationParser: _router.routeInformationParser,
//         routeInformationProvider: _router.routeInformationProvider,
//       );
//   final GoRouter _router = GoRouter(
//     routes: <GoRoute>[
//       GoRoute(
//         routes: <GoRoute>[
//           GoRoute(
//             path: '/dashboard',
//             builder: (BuildContext context, GoRouterState state) =>
//                 const dashboard(),
//           ),
//         ],
//         path: '/',
//         builder: (BuildContext context, GoRouterState state) =>
//             const LoginPage(),
//       ),
//     ],
//   );