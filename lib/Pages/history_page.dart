// ignore_for_file: camel_case_types, must_be_immutable, unrelated_type_equality_checks

import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_user_interface/Services/station_service.dart';
import 'package:flutter_user_interface/models/station_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class historyPage extends StatefulWidget {
  BoxConstraints constraints;
  historyPage({required this.constraints, super.key});

  @override
  State<historyPage> createState() => _historyPageState();
}

class _historyPageState extends State<historyPage> {
  int stateHistory = 0;
  bool stateStartDate = false;
  bool stateEndDate = false;
  DateTime? startDate, endDate;
  late Timer timer;
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != startDate) {
      setState(() {
        stateStartDate = true;
        startDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != endDate) {
      setState(() {
        stateEndDate = true;
        endDate = picked;
      });
    }
  }

  StreamController streamHistori = StreamController.broadcast();
  List<HistoryModel> listHistori = [];
  List<HistoryModel> listHistoriFilter = [];
  HistoryCount getHistori = HistoryCount();
  Future<void> historiData() async {
    if (stateStartDate && stateEndDate) {
      listHistori = await getHistori.historyFilter(
          dateFormat.format(startDate!), dateFormat.format(endDate!));
      streamHistori.add(listHistori);
    } else {
      listHistori = await getHistori.history();
      streamHistori.add(listHistori);
    }
  }

  @override
  void initState() {
    historiData();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      historiData();
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
          child: Row(
            children: [
              GestureDetector(
                onTap: (){
                  setState(() {
                    stateHistory = 0;
                  });
                },
                child: Text(
                  "History Data",
                  style:
                      TextStyle(color: Colors.black54, fontSize: blockVertical * 4),
                ),
              ),
              SizedBox(width: blockHorizontal*2,),
              GestureDetector(
                 onTap: (){
                    setState(() {
                      stateHistory=1;
                    });
                  },
                child: Text(
                  "History Emergency",
                  style:
                      TextStyle(color: Colors.black54, fontSize: blockVertical * 4),
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: blockVertical * 1,
          indent: (stateHistory==0)?blockHorizontal * 1:blockHorizontal*13,
          endIndent: (stateHistory==0)?blockHorizontal * 87:blockHorizontal*70,
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
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Start Date:',
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: blockVertical * 3),
                    ),
                    SizedBox(width: blockHorizontal * 3),
                    OutlinedButton(
                      onPressed: () => _selectStartDate(context),
                      child: startDate != null
                          ? Text(dateFormat.format(startDate!))
                          : Icon(
                              Icons.date_range_outlined,
                              size: blockVertical * 3,
                            ),
                    ),
                    SizedBox(width: blockHorizontal * 3),
                    Text(
                      'End Date:',
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: blockVertical * 3),
                    ),
                    SizedBox(width: blockHorizontal * 3),
                    OutlinedButton(
                      onPressed: () => _selectEndDate(context),
                      child: endDate != null
                          ? Text(dateFormat.format(endDate!))
                          : Icon(
                              Icons.date_range_outlined,
                              size: blockVertical * 3,
                            ),
                    ),
                    SizedBox(
                      width: blockHorizontal * 3,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          setState(() {
                            startDate = null;
                            endDate = null;
                            stateStartDate = false;
                            stateEndDate = false;
                          });
                          historiData();
                        },
                        child: Icon(
                          Icons.restore,
                          size: blockVertical * 3,
                        )),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: blockVertical * 4),
                  height: blockVertical * 70,
                  width: blockHorizontal * 100,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: StreamBuilder(
                      stream: streamHistori.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SingleChildScrollView(
                            child: DataTable(
                                headingRowColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                        (Set<MaterialState> state) {
                                  return Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.5);
                                }),
                                border: TableBorder(
                                  top: BorderSide(
                                      width: blockVertical * 0.2,
                                      color: Colors.black.withOpacity(0.3)),
                                  left: BorderSide(
                                      width: blockVertical * 0.2,
                                      color: Colors.black.withOpacity(0.3)),
                                  right: BorderSide(
                                      width: blockVertical * 0.2,
                                      color: Colors.black.withOpacity(0.3)),
                                  bottom: BorderSide(
                                      width: blockVertical * 0.2,
                                      color: Colors.black.withOpacity(0.3)),
                                  borderRadius:
                                      BorderRadius.circular(blockVertical * 2),
                                  verticalInside: BorderSide(
                                    width: blockVertical * 0.2,
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                  horizontalInside: BorderSide(
                                    width: 3,
                                    color: Colors.black.withOpacity(0.1),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        blockVertical * 3)),
                                columns: [
                                  DataColumn(
                                      label: Text(
                                    "No",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: blockVertical * 4),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    "Tanggal",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: blockVertical * 4),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    "Masuk",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: blockVertical * 4),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    "Stamped",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: blockVertical * 4),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    "Verified",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: blockVertical * 4),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    "Cycle Time",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: blockVertical * 4),
                                  )),
                                ],
                                rows: listHistori.map((e) {
                                  int index = listHistori.indexOf(e);
                                  String number = (index + 1)
                                      .toString()
                                      .padLeft(
                                          listHistori.length.toString().length);
                                  return DataRow(cells: [
                                    DataCell(
                                      SelectableText(
                                        number,
                                        style: TextStyle(
                                          fontSize: blockVertical * 3,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      SelectableText(
                                        "${e.tanggal}",
                                        style: TextStyle(
                                          fontSize: blockVertical * 3,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      SelectableText(
                                        "${e.totalMasuk}",
                                        style: TextStyle(
                                          fontSize: blockVertical * 3,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      SelectableText(
                                        "${e.totalStamped}",
                                        style: TextStyle(
                                          fontSize: blockVertical * 3,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      SelectableText(
                                        "${e.totalVerfied}",
                                        style: TextStyle(
                                          fontSize: blockVertical * 3,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      SelectableText(
                                        "${e.avgCycle}",
                                        style: TextStyle(
                                          fontSize: blockVertical * 3,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ]);
                                }).toList()),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: LoadingAnimationWidget.inkDrop(
                                color: Colors.black45, size: blockVertical * 5),
                          );
                        }
                        return Center(
                          child: Text(
                            "NO DATA",
                            style: TextStyle(fontSize: blockVertical * 5),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
