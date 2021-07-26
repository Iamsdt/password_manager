import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/ext/ext.dart';

class SnackBarHelper {
  static void showSuccess(messageText) {
    if (Get.context == null) return;
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
        backgroundColor: Color(0xff464646),
        content: Row(
          children: [
            Icon(
              Icons.check,
              color: Colors.white,
              size: 28.0.w,
            ),
            SizedBox(
              width: 10.w,
            ),
            Flexible(
              child: Text(
                messageText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0.fontSize,
                  // fontFamily: FontConst.MontserratBold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  static void showInfo(messageText) {
    if (Get.context == null) return;

    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        backgroundColor: Color(0xff464646),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
        content: Row(
          children: [
            Flexible(
              child: Text(
                messageText,
                style: TextStyle(
                  color: Color(0xffEDEDED),
                  fontSize: 14.0.fontSize,
                  // fontFamily: FontConst.MontserratBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void showGetxInfo(String messageText) {
    Get.rawSnackbar(
      messageText: Text(
        messageText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.0.fontSize,
          // fontFamily: FontConst.MontserratBold,
        ),
      ),
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: Color(0xff464646),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(10),
      duration: Duration(seconds: 5),
    );
  }

  static void showGetxError(String messageText) {
    Get.rawSnackbar(
      messageText: Text(
        messageText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.0.fontSize,
          // fontFamily: FontConst.MontserratBold,
        ),
      ),
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(10),
      duration: Duration(seconds: 5),
    );
  }

  static void showError(messageText, {int time = 5}) {
    if (Get.context == null) return;

    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.white,
              size: 28.0.w,
            ),
            SizedBox(
              width: 10.w,
            ),
            Flexible(
              child: Text(
                messageText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0.fontSize,
                  // fontFamily: FontConst.MontserratBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void showLoading(messageText, {int duration = 10}) {
    Get.rawSnackbar(
      messageText: Text(
        messageText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.0.fontSize,
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
