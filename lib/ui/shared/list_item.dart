import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/home/home_controller.dart';
import 'package:password_manager/db/model/password_model.dart';
import 'package:password_manager/ext/ext.dart';
import 'package:password_manager/ui/main/main_ui/password_details_page.dart';

class ListItemUI {
  static ListTile passList(
      BuildContext context, PasswordModel model, Encrypter encrypter) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 20, right: 20),
      onTap: () {
        var modelDe = model.copyWith(
          userName: model.userName.decrypt(encrypter),
          password: model.password.decrypt(encrypter),
        );
        Get.to(PasswordDetailsUI(modelDe));
        //remove foucus
        HomeController.to.removeFocus();
      },
      title: Text(
        model.companyName,
        style: context.textThemeData.bodyText1?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        "Last updated: ${model.accessedOn.readableString()}",
        style: context.textThemeData.bodyText1,
      ),
    );
  }
}
