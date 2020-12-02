import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:password_manager/ext/ext.dart';
import 'package:password_manager/ui/shared/custom_shape.dart';
import 'package:password_manager/utils/image_const.dart';

class AuthHelper {
  static Widget getAppBar({height}) {
    return Material(
      child: Container(
        height: height ?? Get.height * 0.15,
        width: Get.width,
        decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Colors.blue[200], Colors.blueAccent]),
        ),
      ),
    );
  }

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
                colors: [Colors.blue[200], Colors.blueAccent],
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
                  colors: [Colors.blue[200], Colors.blueAccent],
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
  static Widget nameTextFiled(
      TextEditingController controller, String hintText, IconData icon,
      {@required FormFieldValidator<String> validator}) {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: 5,
      child: TextFormField(
        controller: controller,
        cursorColor: Colors.blue[200],
        validator: validator,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.blue[500],
            size: 20,
          ),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  //create button
  static Widget getAuthButton(
    String text,
    void onPresed(),
  ) {
    return RaisedButton(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
        onPresed();
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        width: Get.width * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: <Color>[Colors.blue[200], Colors.blueAccent],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  //helper account creation label
  static Widget infoLabelText(String text) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      //todo remove row
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
        ],
      ),
    );
  }

  //social buttons
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
      margin: EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            hintLabel,
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              onPresed();
            },
            child: Text(
              linkLabel,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.blue[200],
                fontSize: 19,
              ),
            ),
          )
        ],
      ),
    );
  }
}
