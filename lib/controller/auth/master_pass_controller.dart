import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:password_manager/db/store.dart';
import 'package:password_manager/ui/main/bottom_nav.dart';
import 'package:password_manager/ui/shared/snack_bar_helper.dart';

@lazySingleton
class MasterPassController extends GetxController {
  Store store;

  MasterPassController(this.store);

  final TextEditingController passController = TextEditingController();
  final TextEditingController conPassController = TextEditingController();

  var obscureText = true.obs;

  void updatePassword() async {
    var pass1 = passController.text;
    var pass2 = conPassController.text;
    //if two password not matched, return
    if (pass1 != pass2) {
      SnackBarHelper.showError("Password did not match");
      return;
    }

    var res = await store.addMasterPassword(pass1);
    if (res) {
      Get.offAll(BottomNavUI());
    } else {
      SnackBarHelper.showError("Something went wrong, please try again");
    }
  }

  void showPassword() {
    obscureText.update((val) {
      val = !val;
    });
  }

  @override
  void dispose() {
    conPassController.dispose();
    passController.dispose();
    super.dispose();
  }
}
