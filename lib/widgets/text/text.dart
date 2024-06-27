import 'package:flutter/material.dart';

class AllText {
  static Widget text(
      {required double fontsize,
      required color,
      required FontWeight,
      required String text}) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        // fontStyle:,
        fontSize: fontsize,
        color: color,
        fontWeight: FontWeight,
      ),
    );
  }
}
