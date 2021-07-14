import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/auth/check_master_pass_controller.dart';
import 'package:password_manager/di/config_inject.dart';
import 'package:password_manager/ui/auth/recover/recover_master_pass.dart';
import 'package:password_manager/ui/shared/auth_helper_ui.dart';
import 'package:password_manager/ui/shared/widgets/app_clip_share.dart';
import 'package:password_manager/ui/shared/widgets/pass_apbar.dart';
import 'package:password_manager/ext/ext.dart';
import 'package:password_manager/utils/theme/theme_data.dart';

class CheckMasterPassUI extends StatelessWidget {
  final CheckMasterPassController _controller =
      Get.put(getIt<CheckMasterPassController>());

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
              InkWell(
                onTap: () {
                  ThemeService.switchTheme();
                },
                child: const PassClipShare(),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                "Verify master password",
                style: Get.textTheme.headline5,
              ),
              passwordForm(),
              SizedBox(
                height: 10.h,
              ),
              InkWell(
                onTap: () {
                  Get.to(
                    () => RecoverMasterPassUI(),
                    transition: Transition.rightToLeft,
                  );
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.h, horizontal: 30.w),
                  alignment: Alignment.topRight,
                  child: Text(
                    "Forget Master Password",
                    style: Get.textTheme.bodyText1,
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
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
        left: 25.w,
        right: 25.w,
        top: 30.h,
      ),
      child: Form(
        child: Column(
          children: <Widget>[
            AuthHelper.passwordTextFiled(_controller.passController),
          ],
        ),
      ),
    );
  }
}
