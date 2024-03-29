import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/auth/master_pass_controller.dart';
import 'package:password_manager/di/config_inject.dart';
import 'package:password_manager/ui/shared/auth_helper_ui.dart';
import 'package:password_manager/ui/shared/widgets/app_clip_share.dart';
import 'package:password_manager/ui/shared/widgets/pass_apbar.dart';

class MasterPassUI extends StatelessWidget {
  final MasterPassController _controller =
      Get.put(getIt<MasterPassController>(), tag: "MASTER", permanent: true);

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
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "Please add Master Password",
                  style: Get.textTheme.headline5,
                ),
              ),
              passwordForm(),
              SizedBox(
                height: 50,
              ),
              AuthHelper.getAuthButton("Set Master Password", () {
                if (_formKey.currentState?.validate() == true) {
                  _controller.updatePassword();
                }
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
        key: _formKey,
        child: Column(
          children: <Widget>[
            AuthHelper.passwordTextFiled(
              _controller.controller1,
              hint: "Password",
            ),
            SizedBox(height: 10),
            AuthHelper.passwordTextFiled(
              _controller.controller2,
              hint: "Confirm password",
            ),
          ],
        ),
      ),
    );
  }
}
