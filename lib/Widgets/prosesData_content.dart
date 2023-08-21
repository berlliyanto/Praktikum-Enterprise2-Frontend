import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_user_interface/Services/station_service.dart';
import 'package:flutter_user_interface/Widgets/button_material.dart';

Widget cardProcess(
    Widget widget, double blockHorizontal, double blockVertical) {
  return Container(
    padding: EdgeInsets.all(blockVertical * 1.5),
    height: blockVertical * 65,
    width: blockHorizontal * 20,
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 211, 211, 211),
      borderRadius: BorderRadius.circular(blockVertical * 2),
      border: Border.all(color: const Color.fromARGB(137, 114, 114, 114)),
    ),
    child: widget,
  );
}

Widget countingProcess(BuildContext context, double blockHorizontal,
    double blockVertical,String mulai, String stamped, String verified) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Counting BK",
            style: TextStyle(
                color: Colors.black54,
                fontSize: blockVertical * 3.5,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      SizedBox(
        height: blockVertical * 3,
      ),
      Text(
        "Masuk :",
        style: TextStyle(
            color: Colors.black54,
            fontSize: blockVertical * 3.5,
            fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: blockVertical * 1,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            mulai,
            style: TextStyle(
                color: Colors.black54,
                fontSize: blockVertical * 8,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      SizedBox(
        height: blockVertical * 1,
      ),
      Text(
        "Stamped :",
        style: TextStyle(
            color: Colors.black54,
            fontSize: blockVertical * 3.5,
            fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: blockVertical * 1,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            stamped,
            style: TextStyle(
                color: Colors.black54,
                fontSize: blockVertical * 8,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      Text(
        "Verified :",
        style: TextStyle(
            color: Colors.black54,
            fontSize: blockVertical * 3.5,
            fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: blockVertical * 1,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            verified,
            style: TextStyle(
                color: Colors.black54,
                fontSize: blockVertical * 8,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      SizedBox(
        height: blockVertical * 1,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buttonMaterial(
              blockVertical * 5,
              blockHorizontal * 8,
              blockVertical * 3,
              "RESET",
              Colors.red,
              Colors.redAccent,
              Colors.red,
              Colors.redAccent, () {
            ResetCounting.reset().then((value) {
              if (value == true) {
                AwesomeDialog(
                  context: context,
                  width: blockHorizontal * 30,
                  dialogType: DialogType.success,
                  title: "Berhasil Reset",
                  btnOkOnPress: () {},
                  useRootNavigator: true,
                ).show();
              } else {
                AwesomeDialog(
                  context: context,
                  width: blockHorizontal * 30,
                  dialogType: DialogType.warning,
                  title: "Gagal Reset ",
                  btnOkOnPress: () {},
                  useRootNavigator: true,
                ).show();
              }
            });
          }),
        ],
      ),
    ],
  );
}

Widget cycleTime(
  double blockHorizontal,
  double blockVertical,
  String cycle
) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        "Cycle Time",
        style: TextStyle(
            color: Colors.black54,
            fontSize: blockVertical * 3.5,
            fontWeight: FontWeight.bold),
      ),
      SizedBox(height: blockVertical*10,),
      Text(cycle, style: TextStyle(fontSize: blockVertical*20, fontWeight: FontWeight.bold, color: Colors.black54),),
      Text("Detik", style: TextStyle(fontSize: blockVertical*8, fontWeight: FontWeight.bold, color: Colors.black54),),
    ],
  );
}

Widget stockBK(double blockHorizontal, double blockVertical, String amount,
    VoidCallback kurang, VoidCallback tambah, String tambahJumlah, VoidCallback reset) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        "Amount BK",
        style: TextStyle(
            color: Colors.black54,
            fontSize: blockVertical * 3.5,
            fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: blockVertical * 9,
      ),
      Text(
        amount,
        style: TextStyle(
            color: Colors.black54,
            fontSize: blockVertical * 15,
            fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: blockVertical * 5,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: kurang,
            child: CircleAvatar(
              backgroundColor: Colors.red,
              radius: blockVertical * 3,
              child: Icon(
                Icons.exposure_minus_1,
                size: blockVertical * 4,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            tambahJumlah,
            style: TextStyle(
                color: Colors.black54,
                fontSize: blockVertical * 9,
                fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: tambah,
            child: CircleAvatar(
              backgroundColor: Colors.green,
              radius: blockVertical * 3,
              child: Icon(
                Icons.plus_one,
                size: blockVertical * 4,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: blockVertical*1,),
      buttonMaterial(
              blockVertical * 5,
              blockHorizontal * 8,
              blockVertical * 3,
              "TAMBAH",
              const Color.fromARGB(255, 38, 80, 14),
              const Color.fromARGB(255, 3, 88, 47),
              const Color.fromARGB(255, 17, 105, 20),
              const Color.fromARGB(255, 3, 90, 48), () {
            AmountBK.tambahBK(tambahJumlah);
          }),
        SizedBox(height: blockVertical*1,),
      buttonMaterial(
              blockVertical * 5,
              blockHorizontal * 8,
              blockVertical * 3,
              "RESET",
              Colors.red,
              Colors.redAccent,
              Colors.red,
              Colors.redAccent, reset),
    ],
  );
}
