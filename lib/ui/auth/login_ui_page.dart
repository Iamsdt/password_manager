import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/auth/login_controller.dart';
import 'package:password_manager/di/config_inject.dart';
import 'package:password_manager/ui/auth/signup_page.dart';
import 'package:password_manager/ui/shared/auth_helper_ui.dart';
import 'package:password_manager/ui/shared/snack_bar_helper.dart';
import 'package:password_manager/utils/validate_checker.dart';

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
            AuthHelper.nameTextFiled(
              _controller.emailController,
              "Email address",
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
    return ObxValue(
      (data) => Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5,
        child: TextFormField(
          controller: _controller.passController,
          cursorColor: Colors.blue[200],
          validator: (value) => value.isNotEmpty && value.length >= 6
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
