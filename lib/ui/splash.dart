import 'dart:async';

import 'package:encrypt/encrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/controller/app_controller.dart';
import 'package:password_manager/di/config_inject.dart';
import 'package:password_manager/envs.dart';
import 'package:password_manager/ui/auth/check_master_password.dart';
import 'package:password_manager/ui/auth/login_ui_page.dart';
import 'package:password_manager/ui/auth/verify_otp.dart';
import 'package:password_manager/ui/main/bottom_nav.dart';
import 'package:password_manager/utils/encrtypt.dart';
import 'package:password_manager/utils/image_const.dart';

class SplashUI extends StatefulWidget {
  @override
  _SplashUIState createState() => _SplashUIState();
}

class _SplashUIState extends State<SplashUI> {
  final AppController _controller = Get.put(
    getIt<AppController>(),
    tag: "APP",
    permanent: true,
  );

  @override
  void initState() {
    Timer(Duration(seconds: 1), () => _controller.handleSplashScreen());
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
