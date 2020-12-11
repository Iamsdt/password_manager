import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/home/home_controller.dart';
import 'package:password_manager/db/model/password_model.dart';
import 'package:password_manager/ui/main/main_ui/password_details_page.dart';
import 'package:password_manager/ext/ext.dart';

class ListItemUI {
  static ListTile passList(PasswordModel model, Encrypter encrypter) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 20, right: 20),
      onTap: () {
        var modelDe = model.copyWith(
            userName: model.userName.decrypt(encrypter),
            password: model.password.decrypt(encrypter));
        Get.to(PasswordDetailsUI(modelDe));
        //remove foucus
        HomeController.to.removeFocus();
      },
      // leading: Image.asset(
      //   "assets/images/google.png",
      //   width: 32,
      //   height: 32,
      // ),
      title: Text(
        model.companyName ?? "",
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        "Last updated: ${model.accessedOn.readableString()}",
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      // trailing: Container(
      //   width: 20.0,
      //   height: 20.0,
      //   child: CircularProgressIndicator(
      //     value: model.strength / 100.0,
      //     strokeWidth: 7.0,
      //     valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
      //     backgroundColor: Colors.red,
      //   ),
      // ),
    );
  }
}
