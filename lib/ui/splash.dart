import 'dart:async';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:password_manager/envs.dart';
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
    Get.to(BottomNavUI());
  }

  @override
  void initState() {
    Timer(Duration(seconds: 3), () => nextPage);

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
                ImageConst.APP_ICON,
                width: 100,
                height: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
