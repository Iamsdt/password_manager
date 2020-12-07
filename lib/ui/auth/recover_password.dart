import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/auth/login_controller.dart';
import 'package:password_manager/ui/shared/auth_helper_ui.dart';
import 'package:password_manager/ui/shared/snack_bar_helper.dart';
import 'package:password_manager/utils/validate_checker.dart';

class RecoverPasswordUI extends StatelessWidget {
  final LoginController _controller = Get.find();
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
                height: 50,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "Recover password",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              loginForm(),
              SizedBox(
                height: 50,
              ),
              AuthHelper.getAuthButton("RECOVER", () {
                if (_formKey.currentState.validate()) {
                  _controller.recoverPassword();
                } else {
                  SnackBarHelper.showError("Please input valid data");
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginForm() {
    return Container(
      margin: EdgeInsets.only(
        left: 25,
        right: 25,
        top: 30,
      ),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: <Widget>[
            AuthHelper.normalTextField(
              _controller.emailController,
            ),
          ],
        ),
      ),
    );
  }
}
