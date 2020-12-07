import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/auth/login_controller.dart';
import 'package:password_manager/di/config_inject.dart';
import 'package:password_manager/ui/auth/recover_password.dart';
import 'package:password_manager/ui/auth/signup_page.dart';
import 'package:password_manager/ui/shared/auth_helper_ui.dart';
import 'package:password_manager/ui/shared/snack_bar_helper.dart';

class LoginPageUI extends StatelessWidget {
  final LoginController _controller = Get.put(getIt<LoginController>());
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
              loginForm(),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Get.to(RecoverPasswordUI());
                },
                child: Container(
                  padding: EdgeInsets.only(right: 30),
                  alignment: Alignment.topRight,
                  child: Text(
                    "Forget password",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              AuthHelper.getAuthButton("SIGN IN", () {
                if (_formKey.currentState.validate()) {
                  _controller.login();
                } else {
                  SnackBarHelper.showError("Please input valid data");
                }
              }),
              AuthHelper.infoLabelText("Or signin using social media"),
              AuthHelper.socialIconsButtons(() {
                //google click
                _controller.googleLogin();
              }, () {
                //facebook click
                _controller.facebookLogin();
              }),
              AuthHelper.loginORSignupText("New here?", "Sign Up", () {
                Get.to(SignupPageUI());
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
        top: 60,
      ),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: <Widget>[
            AuthHelper.normalTextField(_controller.emailController),
            SizedBox(height: 10),
            AuthHelper.passwordTextFiled(_controller.passController),
          ],
        ),
      ),
    );
  }
}
