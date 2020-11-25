import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/ext/ext.dart';

class SavePasswordUI extends StatefulWidget {
  @override
  _SavePasswordState createState() => _SavePasswordState();
}

class _SavePasswordState extends State<SavePasswordUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Add New Password",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.close,
            color: Colors.blue,
            size: 28,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        child: ListView(
          children: [
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Text(
                    "Title: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(hintText: "write a title"),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.black.withOpacity(0.1),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    width: Get.width * 0.8,
                    child: Text(
                      "Username",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  showUsernameBox(),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: Get.width * 0.8,
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Password",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  showPasswordBox(),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            // analysis report
            SizedBox(
              height: 50,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.black.withOpacity(0.02),
              ),
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(left: 10, right: 10),
              padding: EdgeInsets.all(10),
              child: Text(
                "+ Add Notes",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ).materialClick(() {
              //add notes dialogs
            }),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: Get.width * 0.5,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF00B9FF),
                    ),
                    color: Color(0xFF00B9FF),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      // _loginController.requestLogin();
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text(
                        "SAVE",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container showUsernameBox() {
    return Container(
      alignment: Alignment.center,
      width: Get.width * 0.8,
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.white,
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "username",
          suffixIcon: Icon(
            Icons.visibility,
            color: Colors.black,
          ).materialClick(() {
            //change icon
          }),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Container showPasswordBox() {
    return Container(
      alignment: Alignment.center,
      width: Get.width * 0.8,
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.white,
      ),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          hintText: "password",
          suffixIcon: Icon(
            Icons.visibility_off,
            color: Colors.black,
          ).materialClick(() {
            //password
          }),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
