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
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "Please add Master Password",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
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
        top: 30,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            passwordTextFiled(_controller.passController, "Password"),
            SizedBox(height: 10),
            passwordTextFiled2(
                _controller.conPassController, "Confirm password"),
          ],
        ),
      ),
    );
  }

  Widget passwordTextFiled(TextEditingController controller, String hint) {
    return ObxValue(
      (data) => Material(
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

  Widget passwordTextFiled2(TextEditingController controller, String hint) {
    return ObxValue(
      (data) => Material(
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
                data.value
                    ? Icons.visibility_off
                    : Icons.visibility,
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
