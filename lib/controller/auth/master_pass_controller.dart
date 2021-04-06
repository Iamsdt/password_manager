import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:password_manager/db/store.dart';
import 'package:password_manager/ui/auth/security_question.dart';
import 'package:password_manager/ui/main/bottom_nav.dart';
import 'package:password_manager/ui/shared/snack_bar_helper.dart';
import 'package:password_manager/ext/ext.dart';

@lazySingleton
class MasterPassController extends GetxController {
  Store store;

  MasterPassController(this.store);

  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();

  void updatePassword() async {
    var pass1 = controller1.text;
    var pass2 = controller2.text;
    //if two password not matched, return
    if (pass1 != pass2) {
      SnackBarHelper.showError("Password did not match");
      return;
    }

    var res = await store.addMasterPassword(pass1);
    if (res) {
      //reset controller
      controller1.clear();
      controller2.clear();
      Get.off(SecurityQuestionUI());
      SnackBarHelper.showSuccess("Master password updated successfully");
      getData();
    } else {
      SnackBarHelper.showError("Something went wrong, please try again");
    }
  }

  // get master password
  void getData() async {
    Encrypter encrypter = Get.find(tag: "ENCRYPT");

    var data = await store.getSecurityQuestion();
    if (data.exists) {
      var question = data.data()?['question'] ?? "";
      var ans = data.data()?['answer'] ?? "";
      controller1.text = question;
      controller2.text = ans.toString().decrypt(encrypter);
    }
  }

  void updateSecurityQuestion() async {
    var question = controller1.text;
    var answer = controller2.text;
    var res = await store.addMasterSecurityQuestion(question, answer);

    if (res) {
      //delete master controller
      Get.delete(tag: "MASTER");
      Get.offAll(BottomNavUI());
      SnackBarHelper.showSuccess("Security Question updated successfully");
    } else {
      SnackBarHelper.showSuccess("Something went wrong");
    }
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }
}
