import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:password_manager/ui/shared/custom_shape.dart';
import 'package:password_manager/utils/image_const.dart';

class SignupPage extends StatelessWidget {
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
              createAppBar(),
              clipShape(),
              signUPForm(),
              SizedBox(
                height: 50,
              ),
              signUpButton(),
              infoTextRow(),
              socialIconsRow(),
              //signInTextRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget createAppBar() {
    return Material(
      child: Container(
        height: Get.height * 0.15,
        width: Get.width,
        decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Colors.blue[200], Colors.blueAccent]),
        ),
      ),
    );
  }

  Widget clipShape() {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: FirstCliper(),
          child: Container(
            height: Get.height * 0.15,
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
              height: Get.height * 0.15,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[200], Colors.blueAccent],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: Get.height * 0.05,
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

  Widget signUPForm() {
    return Container(
      margin: EdgeInsets.only(
        left: 25,
        right: 25,
        top: 50,
      ),
      child: Form(
        child: Column(
          children: <Widget>[
            fullNameTextField(),
            SizedBox(height: 10),
            emailTextFormField(),
            SizedBox(height: 10),
            passwordTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget fullNameTextField() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: 5,
      child: TextFormField(
        cursorColor: Colors.blue[200],
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.person,
            color: Colors.blue[500],
            size: 20,
          ),
          hintText: "Full name",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget emailTextFormField() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: 5,
      child: TextFormField(
        cursorColor: Colors.blue[200],
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email,
            color: Colors.blue[500],
            size: 20,
          ),
          hintText: "Email adress",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget passwordTextFormField() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: 5,
      child: TextFormField(
        cursorColor: Colors.blue[200],
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
        ),
        obscureText: true,
      ),
    );
  }

  Widget signUpButton() {
    return RaisedButton(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
        print("Routing to your account");
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        width: Get.width * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: <Color>[Colors.orange[200], Colors.pinkAccent],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text(
          'SIGN UP',
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  Widget infoTextRow() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Or create using social media",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget socialIconsRow() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 15,
            backgroundImage: AssetImage("assets/images/google.png"),
          ),
          SizedBox(
            width: 20,
          ),
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage("assets/images/fblogo.jpg"),
          ),
          SizedBox(
            width: 20,
          ),
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage("assets/images/twitterlogo.jpg"),
          ),
        ],
      ),
    );
  }

  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Already have an account?",
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              // Navigator.of(context).pop(SIGN_IN);
              print("Routing to Sign up screen");
            },
            child: Text(
              "Sign in",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.orange[200],
                fontSize: 19,
              ),
            ),
          )
        ],
      ),
    );
  }
}
