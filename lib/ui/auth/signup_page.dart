import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/ext/ext.dart';
import 'package:password_manager/controller/auth/signup_controller.dart';
import 'package:password_manager/di/config_inject.dart';
import 'package:password_manager/ui/auth/login_ui_page.dart';
import 'package:password_manager/ui/shared/auth_helper_ui.dart';
import 'package:password_manager/ui/shared/widgets/app_clip_share.dart';
import 'package:password_manager/ui/shared/widgets/pass_apbar.dart';

class SignupPageUI extends StatelessWidget {
  late final SignupController _controller = Get.put(getIt<SignupController>());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: context.heightPx,
        width: context.widthPx,
        margin: EdgeInsets.only(bottom: 5.h),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const PassAppBar(),
              PassClipShare(
                roundIconTop: Get.height * 0.02,
                firstCliperHight: Get.height * 0.15,
                secondCliperHeight: Get.height * 0.15,
              ),
              signUPForm(),
              SizedBox(
                height: 30.h,
              ),
              AuthHelper.getAuthButton("SIGN UP", () {
                if (_formKey.currentState?.validate() == true) {
                  _controller.signup();
                }
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
                Get.off(() => LoginPageUI(),
                    transition: Transition.leftToRight);
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
        left: 25.w,
        right: 25.w,
        top: 30.h,
      ),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          children: <Widget>[
            AuthHelper.normalTextField(
              _controller.nameController,
              hint: "Full name",
              icon: Icons.person,
              validator: (value) => value?.isNotEmpty == true
                  ? null
                  : "Please enter your full name",
            ),
            SizedBox(height: 10.h),
            AuthHelper.normalTextField(
              _controller.emailController,
            ),
            SizedBox(height: 10.h),
            AuthHelper.passwordTextFiled(_controller.passController),
          ],
        ),
      ),
    );
  }
}
