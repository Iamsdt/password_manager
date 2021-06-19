import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/app_controller.dart';
import 'package:password_manager/ext/ext.dart';
import 'package:password_manager/ui/shared/auth_helper_ui.dart';
import 'package:password_manager/ui/shared/widgets/app_clip_share.dart';
import 'package:password_manager/ui/shared/widgets/pass_apbar.dart';

class ChnageMasterPasswordUI extends StatelessWidget {
  String currentpass = "";
  String newpass = "";
  String confirmPass = "";

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
                  "Update Masterpassword",
                  style: context.textThemeData.headline5,
                ),
              ),
              passwordForm(context),
              SizedBox(
                height: 50,
              ),
              AuthHelper.getAuthButton("UPDATE", () {
                if (_formKey.currentState?.validate() == true) {
                  AppController.to
                      .updateMasterPassword(currentpass, newpass, confirmPass);
                }
              }),
              //signInTextRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget passwordForm(BuildContext context) {
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
            passwordTextFiled(
              context,
              "Current Password",
              (value) {
                currentpass = value;
              },
            ),
            SizedBox(height: 10),
            passwordTextFiled(
              context,
              "New password",
              (value) {
                currentpass = value;
              },
            ),
            SizedBox(height: 10),
            passwordTextFiled(
              context,
              "Confirm password",
              (value) {
                confirmPass = value;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget passwordTextFiled(
      BuildContext context, String hint, void onChange(String value)) {
    return ObxValue<RxBool>(
      (data) => Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5,
        color: Get.isDarkMode ? Colors.white30 : Colors.white,
        child: TextFormField(
          onChanged: (value) {
            onChange(value);
          },
          style: context.textThemeData.bodyText1,
          cursorColor: Colors.blue[200],
          validator: (v) {
            var value = v ?? "";
            return value.isNotEmpty && value.length >= 6
                ? null
                : "Enter valid password (min length: 6)";
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.blue[500],
              size: 20,
            ),
            hintText: hint,
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
