import 'package:flutter/material.dart';

class CommonUI {
  static Widget showLoading() {
    return Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }

  static Widget showOffline() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Text(
        "No internet avaiable",
        style: TextStyle(
          color: Colors.red,
          fontSize: 18.0,
        ),
      ),
    );
  }

  static Widget showFailed(String text) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.red,
          fontSize: 18.0,
        ),
      ),
    );
  }
}
