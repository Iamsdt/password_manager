import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/auth/security_question_controller.dart';
import 'package:password_manager/di/config_inject.dart';
import 'package:password_manager/ui/shared/auth_helper_ui.dart';

class RecoverMasterPassUI extends StatelessWidget {
  final RecoverQuestionController controller =
      Get.put(getIt<RecoverQuestionController>());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        margin: EdgeInsets.only(bottom: 5),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              AuthHelper.getAppBar(height: Get.height * 0.15),
              AuthHelper.clipShape(
                roundIconTop: Get.height * 0.07,
                firstCliperHight: Get.height * 0.2,
                secondCliperHeight: Get.height * 0.2,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "Verify Security Question?",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              questionForm(),
              SizedBox(
                height: 50,
              ),
              AuthHelper.getAuthButton("UPDATE", () {
                if (_formKey.currentState?.validate() == true) {
                  controller.updateSecurityQuestion();
                }
              }),
              //signInTextRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget questionForm() {
    return Container(
      margin: EdgeInsets.only(
        left: 25,
        right: 25,
        top: 30,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            questionTextField(controller.controller1),
            SizedBox(height: 10),
            answerTextField(controller.controller2),
          ],
        ),
      ),
    );
  }

  Widget questionTextField(TextEditingController editingController) {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: 5,
      child: TextFormField(
        controller: editingController,
        cursorColor: Colors.blue[200],
        enabled: false,
        validator: (value) =>
            value?.isNotEmpty == true ? null : "Please add a valid question",
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.question_answer,
            color: Colors.blue[500],
            size: 20,
          ),
          hintText: "Write question",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget answerTextField(TextEditingController editingController) {
    return ObxValue<RxBool>(
      (data) => Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5,
        child: TextFormField(
          controller: editingController,
          cursorColor: Colors.blue[200],
          validator: (value) =>
              value?.isNotEmpty == null ? null : "Please add a valid answer",
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.chat_sharp,
              color: Colors.blue[500],
              size: 20,
            ),
            hintText: "Write answer",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                data.value = !data.value;
              },
              child: Icon(
                data.value ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          ),
          obscureText: data.value,
        ),
      ),
      true.obs,
    );
  }
}
