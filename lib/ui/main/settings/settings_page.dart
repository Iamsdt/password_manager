import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/ui/auth/login_ui_page.dart';
import 'package:password_manager/ui/recover/change_master_pass.dart';
import 'package:password_manager/ui/recover/change_security_question.dart';

class SettingsPageUi extends StatelessWidget {
  SettingsPageUi({Key key}) : super(key: key);

  final User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amberAccent,
        elevation: 0.0,
      ),
      body: ListView(
        children: [
          Container(
            height: Get.height * 0.3,
            width: Get.width,
            color: Colors.amberAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  child: Text(
                    "${user.displayName}".substring(0, 2),
                    style: TextStyle(
                      fontSize: 48,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "${user.displayName}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 20),
            child: Text(
              "Master password",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.cyan,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: () {
              Get.to(ChnageMasterPasswordUI());
            },
            title: Text(
              "Change master password",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Get.to(ChangeSecurityQuestionUI());
            },
            title: Text(
              "Change security question",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 20),
            child: Text(
              "Theme",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.cyan,
              ),
            ),
          ),
          SwitchListTile(
            title: Text("Use dark Theme"),
            value: false,
            onChanged: (value) {},
          ),
          SizedBox(height: 20),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Get.to(LoginPageUI());
            },
            title: Text(
              "Logout",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.cyan,
              ),
            ),
            trailing: Icon(Icons.logout),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
