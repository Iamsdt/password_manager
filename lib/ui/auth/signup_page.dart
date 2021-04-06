import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/auth/signup_controller.dart';
import 'package:password_manager/di/config_inject.dart';
import 'package:password_manager/ui/auth/login_ui_page.dart';
import 'package:password_manager/ui/shared/auth_helper_ui.dart';

class SignupPageUI extends StatelessWidget {
  final SignupController _controller = Get.put(getIt<SignupController>());
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
                roundIconTop: Get.height * 0.02,
                firstCliperHight: Get.height * 0.15,
                secondCliperHeight: Get.height * 0.15,
              ),
              signUPForm(),
              SizedBox(
                height: 50,
              ),
              AuthHelper.getAuthButton("SIGN UP", () {
                if (_formKey.currentState?.validate() == true) {
                  _controller.signup();
                }
                // Get.to(MasterPassUI());
              }),
              AuthHelper.infoLabelText("Or create using social media"),
              AuthHelper.socialIconsButtons(() {
                //google click
                _controller.googleLogin();
              }, () {
                //facebook click
                _controller.facebookLogin();
              }),
              AuthHelper.loginORSignupText(
                  "Already have an account?", "Sign In", () {
                Get.off(LoginPageUI());
              }),
              //signInTextRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget signUPForm() {
    return Container(
      margin: EdgeInsets.only(
        left: 25,
        right: 25,
        top: 50,
      ),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: <Widget>[
            AuthHelper.normalTextField(
              _controller.nameController,
              hint: "Full name",
              icon: Icons.person,
              // Todo fix this error
              validator: (value) => value?.isNotEmpty == true
                  ? null
                  : "Please enter your full name",
            ),
            SizedBox(height: 10),
            AuthHelper.normalTextField(
              _controller.emailController,
            ),
            SizedBox(height: 10),
            AuthHelper.passwordTextFiled(_controller.passController),
          ],
        ),
      ),
    );
  }
}
