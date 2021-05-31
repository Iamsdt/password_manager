import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:password_manager/ext/ext.dart';
import 'package:password_manager/ui/shared/custom_shape.dart';
import 'package:password_manager/utils/image_const.dart';
import 'package:password_manager/utils/validate_checker.dart';

class AuthHelper {
  //cliper
  static Widget clipShape({
    firstCliperHight,
    secondCliperHeight,
    roundIconTop,
  }) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: FirstCliper(),
          child: Container(
            height: firstCliperHight ?? Get.height * 0.2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[200]!, Colors.blueAccent],
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.4,
          child: ClipPath(
            clipper: SecondCliper(),
            child: Container(
              height: secondCliperHeight ?? Get.height * 0.2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[200]!, Colors.blueAccent],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: roundIconTop ?? Get.height * 0.07,
          left: 0,
          right: 0,
          child: Container(
              height: Get.height * 0.12,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 0.0,
                    color: Colors.black26,
                    offset: Offset(1.0, 10.0),
                    blurRadius: 20.0,
                  ),
                ],
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                ImageConst.PASSWORD_ICON,
                width: 50,
                height: 60,
              )),
        ),
      ],
    );
  }

  //normal text field
  //most of the case it will use as email password
  static Widget normalTextField(
    TextEditingController controller, {
    FormFieldValidator<String>? validator,
    String hint = "Email address",
    IconData icon = Icons.email,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: 3,
      color: Get.theme.bottomSheetTheme.backgroundColor,
      child: TextFormField(
        controller: controller,
        cursorColor: Colors.blue[200],
        validator: validator != null
            ? validator
            : (value) => Validator.isEmailValid(value ?? "")
                ? null
                : "Please enter a valid email",
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.blue[500],
            size: 20,
          ),
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
        ),
        style: Get.textTheme.bodyText1,
      ),
    );
  }

  //static password filed
  static Widget passwordTextFiled(TextEditingController editingController,
      {String hint = "Password", FormFieldValidator<String>? validator}) {
    return ObxValue<RxBool>(
      (data) => Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: 3,
        color: Get.theme.bottomSheetTheme.backgroundColor,
        child: TextFormField(
          controller: editingController,
          cursorColor: Colors.blue[200],
          validator: validator != null
              ? validator
              : (value) {
                  var v = value ?? "";
                  return v.isNotEmpty == true && v.length >= 6
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
          style: Get.textTheme.bodyText1,
        ),
      ),
      true.obs,
    );
  }

  //create button
  static Widget getAuthButton(
    String text,
    void onPresed(),
  ) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        onTap: () {
          onPresed();
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            gradient: LinearGradient(
              colors: <Color>[
                Colors.blue[200]!,
                Colors.blueAccent,
              ],
            ),
          ),
          width: Get.width * 0.5,
          padding: const EdgeInsets.all(12.0),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16.fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  //helper account creation label
  static Widget infoLabelText(String text) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        text,
        style: Get.textTheme.bodyText1,
      ),
    );
  }

  //social buttons
  // todo update icons
  static Widget socialIconsButtons(
    void googleClick(),
    void facebookClick(),
  ) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 15,
            backgroundImage: AssetImage(ImageConst.GOOGLE_IMG),
          ).materialClick(() {
            googleClick();
          }),
          SizedBox(
            width: 20,
          ),
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage(ImageConst.FACEBOOK_IMG),
          ).materialClick(() {
            facebookClick();
          }),
        ],
      ),
    );
  }

  //sign in or signup hint text
  static Widget loginORSignupText(
    String hintLabel,
    String linkLabel,
    void onPresed(),
  ) {
    return Container(
      margin: EdgeInsets.only(top: 20.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            hintLabel,
            style: Get.theme.textTheme.bodyText1,
          ),
          SizedBox(
            width: 5.w,
          ),
          GestureDetector(
            onTap: () {
              onPresed();
            },
            child: Text(
              linkLabel,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue[200],
                fontSize: 20.fontSize,
              ),
            ),
          )
        ],
      ),
    );
  }
}
