import 'package:flutter/cupertino.dart';

class SDP {
  static int? dimen;
  static double? width;
  static BuildContext? contex;

  static void init(BuildContext context) {
    contex = context;
    width = MediaQuery.of(contex!).size.width;
  }

  static double sdp(double dp) {
    return (dp / 300) * width!;
  }
}