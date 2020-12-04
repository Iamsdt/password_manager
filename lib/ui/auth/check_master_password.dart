import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/auth/check_master_pass_controller.dart';
import 'package:password_manager/di/config_inject.dart';
import 'package:password_manager/ui/shared/auth_helper_ui.dart';

class CheckMasterPassUI extends StatelessWidget {
  final CheckMasterPassController _controller =
      Get.put(getIt<CheckMasterPassController>());

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
              Text(
                "Verify master password",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              passwordForm(),
              SizedBox(
                height: 50,
              ),
              AuthHelper.getAuthButton("VERIFY", () {
                _controller.updatePassword();
              }),
              //signInTextRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget passwordForm() {
    return Container(
      margin: EdgeInsets.only(
        left: 25,
        right: 25,
        top: 30,
      ),
      child: Form(
        child: Column(
          children: <Widget>[
            passwordTextFiled(_controller.passController),
          ],
        ),
      ),
    );
  }

  Widget passwordTextFiled(TextEditingController controller) {
    return Obx(
      () => Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5,
        child: TextFormField(
          controller: controller,
          cursorColor: Colors.blue[200],
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email,
              color: Colors.blue[500],
              size: 20,
            ),
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                _controller.showPassword();
              },
              child: Icon(
                _controller.obscureText.value
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
            ),
          ),
          obscureText: _controller.obscureText.value,
        ),
      ),
    );
  }
}
