import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension SnackbarX on BuildContext {
  showSnackbar(String text,
      {Color bcgColor: Colors.black,
      Color textColor: Colors.white,
      double size: 16}) {
    Scaffold.of(this).showSnackBar(
      SnackBar(
        content: Padding(
          padding: EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: size,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: bcgColor,
      ),
    );
  }
}
