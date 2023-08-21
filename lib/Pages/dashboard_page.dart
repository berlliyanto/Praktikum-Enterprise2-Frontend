// ignore_for_file: camel_case_types, must_be_immutable, unrelated_type_equality_checks

import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_user_interface/Services/station_service.dart';
import 'package:flutter_user_interface/Services/user_service.dart';
import 'package:flutter_user_interface/Widgets/button_material.dart';
import 'package:flutter_user_interface/Widgets/indikator_content.dart';
import 'package:flutter_user_interface/Widgets/prosesData_content.dart';
import 'package:flutter_user_interface/horizontal_scroll.dart';
import 'package:flutter_user_interface/models/station_model.dart';
import 'package:get/get.dart';

class dashboardPage extends StatefulWidget {
  BoxConstraints constraints;
  dashboardPage({required this.constraints, super.key});

  @override
  State<dashboardPage> createState() => _dashboardPageState();
}

class _dashboardPageState extends State<dashboardPage> {
  String verified = "";
  String stamped = "";
  String mulai = "";
  String cycle = "";
  String amount = "0";
  int tambahJumlah = 0;
  late Timer timer;
  StreamController streamIndikator = StreamController.broadcast();
  IndikatorPlant getIndikator = IndikatorPlant();
  List<IndikatorModel> listIndikator = [];
  Future<void> indikatorData() async {
    listIndikator = await getIndikator.indikator();
    streamIndikator.add(listIndikator);
  }

  GetCountingProduct counting = GetCountingProduct();
  Future<void> countingData() async {
    await counting.conting().then((value) {
      setState(() {
        verified = value['verified'];
        stamped = value['stamped'];
        mulai = value['mulai'];
        cycle = value['cycle'];
      });
    });
  }

  AmountBK amountBendaKerja = AmountBK();
  Future<void> amountData() async {
    await amountBendaKerja.getAmount().then((value) {
      setState(() {
        amount = value['amount'];
      });
    });
  }

  void tambah() {
    setState(() {
      tambahJumlah = tambahJumlah + 1;
    });
  }

  void resetJumlah() {
    setState(() {
      tambahJumlah = 0;
    });
  }

  void kurangi() {
    if (tambahJumlah > 0) {
      setState(() {
        tambahJumlah = tambahJumlah - 1;
      });
    }
  }

  @override
  void initState() {
    indikatorData();
    amountData();
    countingData();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      indikatorData();
      countingData();
      amountData();
    });
    super.initState();
  }

  @override
  void dispose() {
    if (timer.isActive) timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double blockHorizontal = widget.constraints.maxWidth / 100;
    double blockVertical = widget.constraints.maxHeight / 100;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: blockHorizontal * 2, top: blockVertical * 2),
          child: Text(
            "Pick & Place Station",
            style:
                TextStyle(color: Colors.black54, fontSize: blockVertical * 4),
          ),
        ),
        Divider(
          thickness: blockVertical * 1,
          indent: blockHorizontal * 1,
          endIndent: blockHorizontal * 79,
        ),
        SizedBox(
          height: blockVertical * 2,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: blockHorizontal * 1),
          margin: EdgeInsets.only(bottom: blockVertical * 0.5),
          color: Colors.transparent,
          height: blockVertical * 85,
          width: blockHorizontal * 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: EdgeInsets.only(right: blockHorizontal * 5),
                    height: blockVertical * 80,
                    width: blockHorizontal * 20,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 225, 225, 225),
                        borderRadius: BorderRadius.circular(blockVertical * 2),
                        border: Border.all(
                            color: const Color.fromARGB(137, 114, 114, 114)),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(2, 2),
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 5)
                        ]),
                    child: StreamBuilder(
                        stream: streamIndikator.stream,
                        builder: (context, snapshot) {
                          return Column(
                              children: listIndikator.map((e) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Indikator",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: blockVertical * 6,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: blockVertical * 3,
                                ),
                                indikatormenu(blockVertical, (e.emg=="1")?Colors.green:Colors.red,
                                    "Emergency",(e.emg=="1")?Icons.check:Icons.close),
                                SizedBox(
                                  height: blockVertical * 3,
                                ),
                                 indikatormenu(blockVertical, (e.running=="1")?Colors.green:Colors.red,
                                    "Running",(e.running=="1")?Icons.check:Icons.close),
                                SizedBox(
                                  height: blockVertical * 3,
                                ),
                                 indikatormenu(blockVertical, (e.izinPLC=="1")?Colors.green:Colors.red,
                                    "Home Post",(e.izinPLC=="1")?Icons.check:Icons.close),
                              ],
                            );
                          }).toList());
                        }),
                  ),
                  Container(
                    padding: EdgeInsets.all(blockVertical * 2),
                    height: blockVertical * 80,
                    width: blockHorizontal * 73,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 225, 225, 225),
                        borderRadius: BorderRadius.circular(blockVertical * 2),
                        border: Border.all(
                            color: const Color.fromARGB(137, 114, 114, 114)),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(2, 2),
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 5)
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Proses Data",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: blockVertical * 6,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: blockVertical * 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            cardProcess(
                                countingProcess(context, blockHorizontal,
                                    blockVertical, mulai, stamped, verified),
                                blockHorizontal,
                                blockVertical),
                            cardProcess(
                                cycleTime(blockHorizontal, blockVertical, cycle),
                                blockHorizontal,
                                blockVertical),
                            cardProcess(
                                stockBK(
                                    blockHorizontal,
                                    blockVertical,
                                    amount,
                                    () {
                                      kurangi();
                                    },
                                    () {
                                      tambah();
                                    },
                                    tambahJumlah.toString(),
                                    () {
                                      resetJumlah();
                                    }),
                                blockHorizontal,
                                blockVertical),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
