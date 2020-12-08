import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:password_manager/db/store.dart';
import 'package:password_manager/ui/shared/snack_bar_helper.dart';
import 'package:password_manager/ext/ext.dart';

@lazySingleton
class SecurityQuestionController extends GetxController {
  Store _store;

  SecurityQuestionController(this._store);

  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();

  void getData() async {
    Encrypter encrypter = Get.find(tag: "ENCRYPT");
    var data = await _store.getSecurityQuestion();
    if (data.exists) {
      var question = data.data()['question'];
      var ans = data.data()['answer'];
      questionController.text = question;
      answerController.text = ans.toString().decrypt(encrypter);
    }
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void updateSecurityQuestion() async {
    var question = questionController.text;
    var answer = answerController.text;
    var res = await _store.addMasterSecurityQuestion(question, answer);

    if (res) {
      SnackBarHelper.showSuccess("Question updated successfully");
    } else {
      SnackBarHelper.showSuccess("Something went wrong");
    }
  }

  @override
  void dispose() {
    questionController.dispose();
    answerController.dispose();
    super.dispose();
  }
}
