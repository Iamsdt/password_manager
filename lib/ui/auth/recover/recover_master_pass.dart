import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/auth/security_question_controller.dart';
import 'package:password_manager/di/config_inject.dart';
import 'package:password_manager/ui/shared/auth_helper_ui.dart';
import 'package:password_manager/ui/shared/widgets/app_clip_share.dart';
import 'package:password_manager/ui/shared/widgets/pass_apbar.dart';
import 'package:password_manager/ext/ext.dart';

class RecoverMasterPassUI extends StatelessWidget {
  late final RecoverQuestionController controller =
      Get.put(getIt<RecoverQuestionController>());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        margin: EdgeInsets.only(bottom: 5.h),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const PassAppBar(),
              const PassClipShare(),
              SizedBox(
                height: 30.h,
              ),
              Container(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Text(
                  "Verify Security Question?",
                  style: context.textThemeData.headline5,
                ),
              ),
              questionForm(),
              SizedBox(
                height: 50.h,
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
        left: 25.w,
        right: 25.w,
        top: 30.h,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            questionTextField(controller.controller1),
            SizedBox(height: 10.h),
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
        style: Get.textTheme.bodyText1,
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
          style: Get.textTheme.bodyText1,
        ),
      ),
      true.obs,
    );
  }
}
