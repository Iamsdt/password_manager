import 'dart:async';

import 'package:encrypt/encrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/envs.dart';
import 'package:password_manager/ui/auth/login_ui_page.dart';
import 'package:password_manager/ui/main/bottom_nav.dart';
import 'package:password_manager/utils/encrtypt.dart';
import 'package:password_manager/utils/image_const.dart';

class SplashUI extends StatefulWidget {
  @override
  _SplashUIState createState() => _SplashUIState();
}

class _SplashUIState extends State<SplashUI> {
  void nextPage() async {
    //before going to this PAGE INIT Encryptor
    Encrypter encrypter =
        initEncryptor(MyEnvironment.passKey, MyEnvironment.paddingKey);
    //put into GetX, so that it can be accessed from across the APP
    Get.put<Encrypter>(encrypter, tag: "ENCRYPT", permanent: true);

    var user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Get.off(BottomNavUI());
    } else {
      Get.to(LoginPageUI());
    }
  }

  @override
  void initState() {
    Timer(Duration(seconds: 1), () => nextPage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                ImageConst.PASSWORD_ICON,
                width: 150,
                height: 150,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Password Manager",
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
