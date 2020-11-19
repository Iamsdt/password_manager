import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarHelper {
  static void showSuccess(messageText) {
    Get.snackbar(
      null,
      null,
      titleText: Text(""),
      messageText: Text(
        messageText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      snackStyle: SnackStyle.GROUNDED,
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(0.0),
      duration: Duration(seconds: 3),
      icon: Icon(
        Icons.check,
        color: Colors.white,
        size: 25.0,
      ),
    );
  }

  static void showInfo(messageText) {
    Get.snackbar(
      null,
      null,
      titleText: Text(""),
      messageText: Text(
        messageText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      snackStyle: SnackStyle.GROUNDED,
      backgroundColor: Colors.cyan,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(0.0),
      duration: Duration(seconds: 3),
      icon: Icon(
        Icons.info_outline,
        color: Colors.white,
        size: 25.0,
      ),
    );
  }

  static void showError(messageText, {int time = 5}) {
    Get.snackbar(
      null,
      null,
      titleText: Text(""),
      messageText: Text(
        messageText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      snackStyle: SnackStyle.GROUNDED,
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(0.0),
      duration: Duration(seconds: time),
    );
  }

  static void showLoading(messageText) {
    Get.snackbar(
      null,
      null,
      titleText: Text(""),
      messageText: Text(
        messageText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      snackStyle: SnackStyle.GROUNDED,
      backgroundColor: Colors.cyan,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(0.0),
      duration: Duration(seconds: 5),
      showProgressIndicator: true,
    );
  }
}
