import 'package:encrypt/encrypt.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:password_manager/db/store.dart';
import 'package:password_manager/ui/main/bottom_nav.dart';
import 'package:password_manager/ext/ext.dart';
import 'package:password_manager/ui/shared/snack_bar_helper.dart';

@lazySingleton
class CheckMasterPassController extends GetxController {
  Store _store;

  CheckMasterPassController(this._store);

  final TextEditingController passController = TextEditingController();

  var obscureText = true.obs;

  void updatePassword() async {
    var res = await _store.getMasterPass();
    Encrypter encrypter = Get.find(tag: "ENCRYPT");
    var current = passController.text.encrypt(encrypter);
    Fimber.i("Current password $current");
    print(current);
    var old = res.data();
    print(old);
    var str = old.toString();
    print(str);

    if (str == current) {
      Get.to(BottomNavUI());
    } else {
      SnackBarHelper.showError("Password did not match, please try again!");
    }
  }

  void showPassword() {
    obscureText.update((val) {
      val = !val;
    });
  }

  @override
  void dispose() {
    passController.dispose();
    super.dispose();
  }
}
