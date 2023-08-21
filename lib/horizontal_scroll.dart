
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class ScrollHorizontal extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.mouse,
    PointerDeviceKind.touch,
    PointerDeviceKind.trackpad,
  };
}