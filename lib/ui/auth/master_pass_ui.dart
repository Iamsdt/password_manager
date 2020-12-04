import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/auth/master_pass_controller.dart';
import 'package:password_manager/di/config_inject.dart';
import 'package:password_manager/ui/shared/auth_helper_ui.dart';

class MasterPassUI extends StatelessWidget {
  final MasterPassController _controller =
      Get.put(getIt<MasterPassController>());

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
              passwordForm(),
              SizedBox(
                height: 50,
              ),
              AuthHelper.getAuthButton("Set Master Password", () {
                if (_formKey.currentState.validate()) {
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
        top: 60,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            passwordTextFiled(_controller.passController),
            SizedBox(height: 10),
            passwordTextFiled(_controller.conPassController),
          ],
        ),
      ),
    );
  }

  Widget passwordTextFiled(TextEditingController controller) {
    return Obx(
      () => Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5,
        child: TextFormField(
          controller: controller,
          cursorColor: Colors.blue[200],
          validator: (value) => value.isNotEmpty && value.length >= 6
              ? null
              : "Enter valid password (min length: 6)",
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email,
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
