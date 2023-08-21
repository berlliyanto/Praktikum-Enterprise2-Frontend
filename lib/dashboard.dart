// ignore_for_file: camel_case_types, non_constant_identifier_names, must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_user_interface/Pages/account_page.dart';
import 'package:flutter_user_interface/Pages/dashboard_page.dart';
import 'package:flutter_user_interface/Pages/history_page.dart';
import 'package:flutter_user_interface/Widgets/animated_sidebar_menu.dart';
import 'package:flutter_user_interface/Widgets/footer.dart';
import 'package:flutter_user_interface/Widgets/header_sidebar.dart';
import 'package:flutter_user_interface/Widgets/navbar.dart';
import 'package:flutter_user_interface/Widgets/sidebar.dart';

class dashboard extends StatefulWidget {
  String? name, level;
  dashboard({required this.name, required this.level, super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  late Timer timer;
  int stateActive = 0;
  bool sidebarCollapse = false;
  @override
  Widget build(BuildContext context) {
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;
    return Scaffold(
      body: AnimatedContainer(
        padding: EdgeInsets.all(blockVertical * 0),
        duration: const Duration(milliseconds: 500),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            color: (stateActive == 0)
                ? const Color.fromARGB(255, 225, 225, 225)
                : (stateActive == 1)
                    ? const Color.fromARGB(255, 155, 155, 155)
                    : const Color.fromARGB(255, 85, 85, 85)),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //NAVBAR
                navbar(
                  state: (sidebarCollapse) ? true : false,
                ),
                //FOOTER
                footer(blockHorizontal, blockVertical,
                    (sidebarCollapse) ? true : false)
              ],
            ),
            //SIDEBAR
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              margin: EdgeInsets.all(blockVertical * 1),
              height: blockVertical * 100,
              width: (!sidebarCollapse)
                  ? blockHorizontal * 16
                  : blockHorizontal * 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(blockVertical * 2),
                gradient: const LinearGradient(
                    colors: [Color.fromARGB(118, 0, 0, 0), Colors.black26],
                    end: Alignment.bottomLeft,
                    begin: Alignment.topRight),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      Container(
                        height: constraints.maxHeight,
                        width: constraints.maxWidth,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: blockVertical * 3,
                              backgroundColor:
                                  const Color.fromARGB(255, 116, 116, 116)
                                      .withOpacity(0.8),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    sidebarCollapse = !sidebarCollapse;
                                  });
                                },
                                icon: Icon(
                                  (!sidebarCollapse)
                                      ? Icons.keyboard_arrow_left_sharp
                                      : Icons.keyboard_arrow_right_sharp,
                                  color: Colors.white,
                                  size: blockVertical * 3,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: constraints.maxHeight * 0.02,
                            )
                          ],
                        ),
                      ),
                      (!sidebarCollapse)
                          ? animatedSidebarMenu(
                              constraints,
                              (stateActive == 0)
                                  ? const Color.fromARGB(95, 70, 70, 70)
                                      .withOpacity(0.5)
                                  : (stateActive == 1)
                                      ? const Color.fromARGB(95, 130, 130, 130)
                                          .withOpacity(0.5)
                                      : const Color.fromARGB(95, 233, 233, 233),
                              (stateActive == 0)
                                  ? 0.17
                                  : (stateActive == 1)
                                      ? 0.28
                                      : 0.39)
                          : animatedSidebarMenuCollapse(
                              constraints,
                              (stateActive == 0)
                                  ? const Color.fromARGB(95, 70, 70, 70)
                                      .withOpacity(0.5)
                                  : (stateActive == 1)
                                      ? const Color.fromARGB(95, 130, 130, 130)
                                          .withOpacity(0.5)
                                      : const Color.fromARGB(95, 233, 233, 233),
                              (stateActive == 0)
                                  ? 0.17
                                  : (stateActive == 1)
                                      ? 0.28
                                      : 0.39),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          headerSidebar(
                              constraints,
                              "${widget.name}",
                              "${widget.level}",
                              (!sidebarCollapse) ? true : false),
                          (!sidebarCollapse)
                              ? sidebarMenu(
                                  constraints,
                                  Icons.home,
                                  "Dashboard",
                                  const Color.fromARGB(255, 92, 92, 92),
                                  Colors.transparent, () {
                                  setState(() {
                                    stateActive = 0;
                                  });
                                }, (stateActive == 0) ? true : false)
                              : collapseSidebarMenu(
                                  constraints,
                                  Icons.home,
                                  const Color.fromRGBO(92, 92, 92, 1),
                                  Colors.transparent, () {
                                  setState(() {
                                    stateActive = 0;
                                  });
                                }, (stateActive == 0) ? true : false),
                          (!sidebarCollapse)
                              ? sidebarMenu(
                                  constraints,
                                  Icons.history,
                                  "History",
                                  const Color.fromARGB(255, 92, 92, 92),
                                  Colors.transparent, () {
                                  setState(() {
                                    stateActive = 1;
                                  });
                                }, (stateActive == 1) ? true : false)
                              : collapseSidebarMenu(
                                  constraints,
                                  Icons.history,
                                  const Color.fromRGBO(92, 92, 92, 1),
                                  Colors.transparent, () {
                                  setState(() {
                                    stateActive = 1;
                                  });
                                }, (stateActive == 1) ? true : false),
                          (widget.level == "Admin")
                              ? (!sidebarCollapse)
                                  ? sidebarMenu(
                                      constraints,
                                      Icons.person,
                                      "Accounts",
                                      const Color.fromARGB(255, 92, 92, 92),
                                      Colors.transparent, () {
                                      setState(() {
                                        stateActive = 2;
                                      });
                                    }, (stateActive == 2) ? true : false)
                                  : collapseSidebarMenu(
                                      constraints,
                                      Icons.person,
                                      const Color.fromARGB(255, 92, 92, 92),
                                      Colors.transparent, () {
                                      setState(() {
                                        stateActive = 2;
                                      });
                                    }, (stateActive == 2) ? true : false)
                              : const SizedBox(
                                  height: 1,
                                ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            //MAIN CONTENT
            AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                margin: EdgeInsets.only(
                    top: blockVertical * 12,
                    left: (!sidebarCollapse)
                        ? blockHorizontal * 17
                        : blockHorizontal * 7),
                padding: EdgeInsets.all(blockVertical * 1),
                height: blockVertical * 81,
                width: (!sidebarCollapse)
                    ? blockHorizontal * 82.5
                    : blockHorizontal * 92.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(blockVertical * 1),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return (stateActive == 0)
                        ? dashboardPage(constraints: constraints)
                        : (stateActive == 1)
                            ? historyPage(constraints: constraints)
                            : accountsPage(constraints: constraints);
                  },
                ))
          ],
        ),
      ),
    );
  }
}
