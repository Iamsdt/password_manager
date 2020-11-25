import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension Click on Widget {
  Widget materialClick(void Function() tap, {void Function() longTap}) {
    return Material(
      child: InkWell(
        onTap: () {
          tap();
        },
        onLongPress: () {
          if (longTap != null) longTap();
        },
        child: this,
      ),
    );
  }
}
