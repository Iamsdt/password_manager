import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class MasterPassController extends GetxController {
  final TextEditingController passController = TextEditingController();
  final TextEditingController conPassController = TextEditingController();

  var obsecureText = true.obs;

  void updatePassword() {}

  void showPassword() {
    obsecureText.update((val) {
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
