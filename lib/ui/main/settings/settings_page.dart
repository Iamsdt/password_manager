import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/ui/recover/change_master_pass.dart';
import 'package:password_manager/ui/recover/change_security_question.dart';
import 'package:password_manager/ui/splash.dart';
import 'package:password_manager/utils/theme/theme_data.dart';

class SettingsPageUi extends StatelessWidget {
  final RxBool themeStatus = ThemeService.currentTheme.obs;

  SettingsPageUi({Key? key}) : super(key: key);

  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: context.theme.bannerTheme.backgroundColor,
        elevation: 0.0,
      ),
      body: ListView(
        children: [
          Container(
            height: Get.height * 0.3,
            width: Get.width,
            color: context.theme.bannerTheme.backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  child: Text(
                    "${user?.email}".substring(0, 2),
                    style: TextStyle(
                      fontSize: 48,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "${user?.email}",
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
              Get.to(ChangeSecurityQuestionUI("Update Security Question"));
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
          ObxValue(
            (data) => SwitchListTile(
              title: Text("Use dark Theme"),
              value: themeStatus.value,
              onChanged: (value) {
                themeStatus.value = value;
                ThemeService.switchTheme();
              },
            ),
            themeStatus,
          ),
          SizedBox(height: 20),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Get.reset(clearFactory: true);
              Get.offAll(SplashUI());
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
