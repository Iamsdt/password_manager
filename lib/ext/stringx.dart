import 'package:flutter/material.dart';

extension TextS on String {
  Widget toText({TextStyle style}) {
    return Text(
      this,
      style: style != null ? style : TextStyle(),
    );
  }
}

extension Nums on String {
  // to int
  int toInt() => int.parse(this.trim());

  //this double
  double toDouble() => double.parse(this.trim());
}
