import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:password_manager/db/store.dart';
import 'package:password_manager/ui/auth/master_pass_ui.dart';
import 'package:password_manager/ui/main/bottom_nav.dart';
import 'package:password_manager/ext/ext.dart';
import 'package:password_manager/ui/shared/snack_bar_helper.dart';

@lazySingleton
class CheckMasterPassController extends GetxController {
  Store _store;

  CheckMasterPassController(this._store);

  final TextEditingController passController = TextEditingController();

  @override
  void onInit() {
    checkMasterPassExists();
    super.onInit();
  }

  void updatePassword() async {
    var res = await _store.getMasterPass();
    Encrypter encrypter = Get.find(tag: "ENCRYPT");
    var current = passController.text.encrypt(encrypter);
    Fimber.i("Current password $current");
    var old = res.data()?["psssword"] ?? "";
    if (old == current) {
      passController.text = "";
      Get.offAll(BottomNavUI());
    } else {
      SnackBarHelper.showError("Password did not match, please try again!");
    }
  }

  void checkMasterPassExists() async {
    // and check user added master pass or not
    // if yes, do nothing
    // if not send to setup master pass page

    //show loading dialog
    Get.dialog(
      Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );

    var res = await _store.checkMasterPassword();

    //hide loading dialog
    //check dialog is showing or user close
    // if (Get.isDialogOpen) {
    //   Get.back();
    // }

    //if not exists then create once
    if (!res) {
      Get.offAll(MasterPassUI());
    }
  }

  @override
  void dispose() {
    passController.dispose();
    super.dispose();
  }
}
