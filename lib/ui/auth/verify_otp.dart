import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/auth/login_controller.dart';
import 'package:password_manager/ui/shared/auth_helper_ui.dart';

class VerifyOTP extends StatelessWidget {
  final LoginController _controller = Get.find();

  final _formKey = GlobalKey<FormState>();

  String otp = "";

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
              Text(
                "Verify OTP",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              passwordForm(),
              SizedBox(
                height: 50,
              ),
              AuthHelper.getAuthButton("VERIFY", () {
                if (_formKey.currentState.validate()) {
                  _controller.verifyOTP(otp);
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
            otpTextFiled(),
          ],
        ),
      ),
    );
  }

  Widget otpTextFiled() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: 5,
      child: TextFormField(
        cursorColor: Colors.blue[200],
        validator: (value) => value.isNotEmpty ? null : "Enter valid OTP",
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email,
            color: Colors.blue[500],
            size: 20,
          ),
          hintText: "OTP",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value) {
          otp = value;
        },
      ),
    );
  }
}
