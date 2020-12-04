import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/auth/signup_controller.dart';
import 'package:password_manager/di/config_inject.dart';
import 'package:password_manager/ui/auth/login_ui_page.dart';
import 'package:password_manager/ui/auth/master_pass_ui.dart';
import 'package:password_manager/ui/shared/auth_helper_ui.dart';
import 'package:password_manager/utils/validate_checker.dart';

class SignupPageUI extends StatelessWidget {
  final SignupController _controller = Get.put(getIt<SignupController>());

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
                Get.to(MasterPassUI());
                // _controller.signup();
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
                Get.to(LoginPageUI());
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
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: <Widget>[
            AuthHelper.nameTextFiled(
              _controller.nameController,
              "Full name",
              Icons.person,
              validator: (value) => value.isNotEmpty && value.length > 3
                  ? null
                  : "Please enter your full name",
            ),
            SizedBox(height: 10),
            AuthHelper.nameTextFiled(
              _controller.emailController,
              "Full name",
              Icons.email,
              validator: (value) => Validator.isEmailValid(value)
                  ? null
                  : "Please enter a valid email",
            ),
            SizedBox(height: 10),
            passwordTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget passwordTextFormField() {
    return Obx(
      () => Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5,
        child: TextFormField(
          controller: _controller.passController,
          cursorColor: Colors.blue[200],
          validator: (value) => value.isNotEmpty && value.length > 6
              ? null
              : "Enter valid password (min length: 6)",
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
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
