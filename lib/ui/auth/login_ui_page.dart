import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/auth/login_controller.dart';
import 'package:password_manager/di/config_inject.dart';
import 'package:password_manager/ext/ext.dart';
import 'package:password_manager/ui/auth/recover/recover_password.dart';
import 'package:password_manager/ui/auth/signup_page.dart';
import 'package:password_manager/ui/shared/auth_helper_ui.dart';
import 'package:password_manager/ui/shared/snack_bar_helper.dart';
import 'package:password_manager/ui/shared/widgets/app_clip_share.dart';
import 'package:password_manager/ui/shared/widgets/pass_apbar.dart';

class LoginPageUI extends StatelessWidget {
  late final LoginController _controller = Get.put(getIt<LoginController>());
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
              loginForm(),
              InkWell(
                onTap: () {
                  Get.to(() => RecoverPasswordUI(),
                      transition: Transition.rightToLeft);
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.h, horizontal: 30.w),
                  alignment: Alignment.topRight,
                  child: Text(
                    "Forget password",
                    style: Get.textTheme.bodyText1,
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              AuthHelper.getAuthButton("SIGN IN", () {
                if (_formKey.currentState?.validate() == true) {
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
              AuthHelper.loginORSignupText(
                "New here?",
                "Sign Up",
                () {
                  Get.off(() => SignupPageUI(),
                      transition: Transition.rightToLeft);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginForm() {
    return Container(
      margin: EdgeInsets.only(
        left: 25.w,
        right: 25.w,
        top: 40.h,
      ),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          children: <Widget>[
            AuthHelper.normalTextField(_controller.emailController),
            SizedBox(height: 10.h),
            AuthHelper.passwordTextFiled(_controller.passController),
          ],
        ),
      ),
    );
  }
}
