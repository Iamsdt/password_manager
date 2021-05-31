import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/auth/login_controller.dart';
import 'package:password_manager/ui/shared/auth_helper_ui.dart';
import 'package:password_manager/ui/shared/snack_bar_helper.dart';
import 'package:password_manager/ui/shared/widgets/app_clip_share.dart';
import 'package:password_manager/ui/shared/widgets/pass_apbar.dart';
import 'package:password_manager/ext/ext.dart';

class RecoverPasswordUI extends StatelessWidget {
  late final LoginController _controller = Get.find();
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
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "Recover password",
                  style: context.textThemeData.headline4,
                ),
              ),
              loginForm(),
              SizedBox(
                height: 50.h,
              ),
              AuthHelper.getAuthButton("RECOVER", () {
                if (_formKey.currentState?.validate() == true) {
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
        autovalidateMode: AutovalidateMode.disabled,
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
