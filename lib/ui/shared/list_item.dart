import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/ui/main/main_ui/password_details_page.dart';

class ListItemUI {
  static ListTile passList() {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 20, right: 20),
      onTap: () {
        Get.to(PasswordDetailsUI());
      },
      // leading: Image.asset(
      //   "assets/images/google.png",
      //   width: 32,
      //   height: 32,
      // ),
      title: Text(
        "Google",
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        "Last updated: 12-10-20",
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Container(
        width: 20.0,
        height: 20.0,
        child: CircularProgressIndicator(
          value: 0.7,
          strokeWidth: 7.0,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          backgroundColor: Colors.red,
        ),
      ),
    );
  }
}
