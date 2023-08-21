import 'package:flutter/material.dart';

Widget indikatormenu(double blockVertical, Color color, String title, IconData icons) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      CircleAvatar(
        radius: blockVertical * 4,
        backgroundColor: color,
        child: Icon(
          icons,
          color: Colors.white,
          size: blockVertical * 4,
        ),
      ),
      Text(
        "     $title",
        style: TextStyle(
            overflow: TextOverflow.fade,
            color: Colors.black54,
            fontSize: blockVertical * 4,
            fontWeight: FontWeight.bold),
      )
    ],
  );
}
