import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/auth/login_controller.dart';
import 'package:password_manager/ui/shared/auth_helper_ui.dart';
import 'package:password_manager/ui/shared/widgets/app_clip_share.dart';
import 'package:password_manager/ui/shared/widgets/pass_apbar.dart';

class VerifyOTP extends StatelessWidget {
  final LoginController _controller = Get.find();

  // final _formKey = GlobalKey<FormState>();

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
                height: 50,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "An email with verification link, " +
                      "sent to your email address, please use that link to verify your account, then click Verified Button",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              // passwordForm(),
              SizedBox(
                height: 50,
              ),
              AuthHelper.getAuthButton("VERIFY", () {
                _controller.verify();
              }),
              //signInTextRow(),
            ],
          ),
        ),
      ),
    );
  }

// Widget passwordForm() {
//   return Container(
//     margin: EdgeInsets.only(
//       left: 25,
//       right: 25,
//       top: 30,
//     ),
//     child: Form(
//       key: _formKey,
//       child: Column(
//         children: <Widget>[
//           otpTextFiled(),
//         ],
//       ),
//     ),
//   );
// }

// Widget otpTextFiled() {
//   return Material(
//     borderRadius: BorderRadius.circular(30.0),
//     elevation: 5,
//     child: TextFormField(
//       cursorColor: Colors.blue[200],
//       validator: (value) => value.isNotEmpty ? null : "Enter valid OTP",
//       decoration: InputDecoration(
//         prefixIcon: Icon(
//           Icons.email,
//           color: Colors.blue[500],
//           size: 20,
//         ),
//         hintText: "OTP",
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(30.0),
//           borderSide: BorderSide.none,
//         ),
//       ),
//       onChanged: (value) {
//         otp = value;
//       },
//     ),
//   );
// }
}
