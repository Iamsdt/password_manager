import 'dart:async';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:password_manager/utils/encrtypt.dart';
import 'package:password_manager/utils/image_const.dart';

class SplashUI extends StatefulWidget {
  @override
  _SplashUIState createState() => _SplashUIState();
}

class _SplashUIState extends State<SplashUI> {
  void nextPage() {
    //todo next page
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
            InkWell(
              onTap: () {
                Encrypter ciper = initEncryptor("HI" * 16, "Hello" * 2);
                String en = encryptString(ciper, "Shudipto", 16);
                print("Enctypted: $en");

                String de = decryptString(ciper, en, 16);
                print("Denctypted: $de");
              },
              child: Container(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  ImageConst.APP_ICON,
                  width: 100,
                  height: 100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
