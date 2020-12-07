import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:password_manager/db/store.dart';

@lazySingleton
class SecurityQuestionController extends GetxController {
  Store _store;

  SecurityQuestionController(this._store);

  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();

  void getData() async {
    var data = await _store.getSecurityQuestion();
    var question = data.data()['question'];
    var ans = data.data()['answer'];

    questionController.text = question;
    answerController.text = ans;
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void updateSecurityQuestion() {}

  @override
  void dispose() {
    questionController.dispose();
    answerController.dispose();
    super.dispose();
  }
}
