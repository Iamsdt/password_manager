import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/app_controller.dart';
import 'package:password_manager/ui/shared/auth_helper_ui.dart';
import 'package:password_manager/ui/shared/widgets/app_clip_share.dart';
import 'package:password_manager/ui/shared/widgets/pass_apbar.dart';

class ChnageMasterPasswordUI extends StatefulWidget {
  @override
  _ChnageMasterPasswordUIState createState() => _ChnageMasterPasswordUIState();
}

class _ChnageMasterPasswordUIState extends State<ChnageMasterPasswordUI> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController currentpass = TextEditingController();
  late TextEditingController newpass = TextEditingController();
  late TextEditingController confirmpass = TextEditingController();

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
                  style: Get.textTheme.headline5,
                ),
              ),
              passwordForm(),
              SizedBox(
                height: 50,
              ),
              AuthHelper.getAuthButton("UPDATE", () {
                if (_formKey.currentState?.validate() == true) {
                  AppController.to.updateMasterPassword(
                      currentpass.text, newpass.text, confirmpass.text);
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
            passwordTextFiled(
              "Current Password",
              currentpass,
            ),
            SizedBox(height: 10),
            passwordTextFiled(
              "New password",
              newpass,
            ),
            SizedBox(height: 10),
            passwordTextFiled(
              "Confirm password",
              confirmpass,
            ),
          ],
        ),
      ),
    );
  }

  Widget passwordTextFiled(String hint, TextEditingController controller) {
    return ObxValue<RxBool>(
      (data) => Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5,
        color: Get.isDarkMode ? Colors.white30 : Colors.white,
        child: TextFormField(
          controller: controller,
          style: Get.textTheme.bodyText1,
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

  @override
  void dispose() {
    currentpass.dispose();
    confirmpass.dispose();
    newpass.dispose();
    super.dispose();
  }
}
