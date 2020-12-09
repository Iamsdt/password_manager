import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:password_manager/db/store.dart';
import 'package:password_manager/ui/auth/master_pass_ui.dart';
import 'package:password_manager/ui/shared/snack_bar_helper.dart';
import 'package:password_manager/ext/ext.dart';

@lazySingleton
class RecoverQuestionController extends GetxController {
  Store store;

  RecoverQuestionController(this.store);

  String answer = "";

  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  // get master password
  void getData() async {
    var data = await store.getSecurityQuestion();
    if (data.exists) {
      var question = data.data()['question'];
      var ans = data.data()['answer'];
      controller1.text = question;
      answer = ans;
    }
  }

  void updateSecurityQuestion() async {
    var answerText = controller2.text;

    Encrypter encrypter = Get.find(tag: "ENCRYPT");
    var en = answerText.encrypt(encrypter);

    if (en == answer) {
      Get.offAll(MasterPassUI());
      SnackBarHelper.showSuccess("Updated master password now");
    } else {
      SnackBarHelper.showSuccess("Answer did not matched");
    }
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }
}
