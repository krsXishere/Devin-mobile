import 'package:flutter/cupertino.dart';

class Dimension {
  static double? boxHeight;
  static double? boxWidth;

  Dimension(context) {
    boxHeight = MediaQuery.of(context).size.height / 100;
    boxWidth = MediaQuery.of(context).size.width / 100;
  }
}
