import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension Click on Widget {
  Widget materialClick(void Function() tap,
      {void Function()? longTap, Color? splashColor}) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        splashColor: splashColor ?? Colors.white.withOpacity(0.25),
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
