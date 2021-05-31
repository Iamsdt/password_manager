import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/recover/security_question_controller.dart';
import 'package:password_manager/di/config_inject.dart';
import 'package:password_manager/ui/shared/auth_helper_ui.dart';
import 'package:password_manager/ui/shared/widgets/app_clip_share.dart';
import 'package:password_manager/ui/shared/widgets/pass_apbar.dart';

class ChangeSecurityQuestionUI extends StatelessWidget {
  final String title;

  ChangeSecurityQuestionUI(this.title);

  final SecurityQuestionController controller =
      Get.put(getIt<SecurityQuestionController>());

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
              const PassAppBar(),
              const PassClipShare(),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  title,
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
            AuthHelper.normalTextField(controller.questionController,
                hint: "Question", icon: Icons.question_answer, validator: (v) {
              var value = v ?? "";
              return value.isNotEmpty ? null : "Please add a valid question";
            }),
            SizedBox(height: 10),
            answerTextFiled(controller.answerController),
          ],
        ),
      ),
    );
  }

  Widget answerTextFiled(TextEditingController editingController) {
    return ObxValue<RxBool>(
      (data) => Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5,
        color: Get.isDarkMode ? Colors.white30 : Colors.white,
        child: TextFormField(
          controller: editingController,
          cursorColor: Colors.blue[200],
          validator: (v) {
            var value = v ?? "";
            return value.isNotEmpty ? null : "Please add a valid answer";
          },
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
