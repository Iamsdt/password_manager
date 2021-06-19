import 'package:flutter/material.dart';
import 'package:password_manager/ext/ext.dart';

class Themes {
  //light theme
  static final light = ThemeData.light().copyWith(
    buttonColor: Colors.blue,
    iconTheme: IconThemeData(color: Colors.black),
    bannerTheme: MaterialBannerThemeData(
      backgroundColor: Colors.amber.shade500,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
    ),
    splashColor: Colors.white,
    textTheme: TextTheme(
      headline4: TextStyle(
        fontSize: 25,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      headline5: TextStyle(
        fontSize: 22,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      headline6: TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: TextStyle(
        fontSize: AppConfig.dimen.defaultFontSize,
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
    ),
  );

  //dark theme
  static final dark = ThemeData.dark().copyWith(
    buttonColor: Colors.red,
    iconTheme: IconThemeData(color: Colors.white),
    bannerTheme: MaterialBannerThemeData(
      backgroundColor: Colors.amber.shade900.withAlpha(200),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.grey[900],
    ),
    splashColor: Colors.grey[900],
    textTheme: TextTheme(
      headline4: TextStyle(
        fontSize: 25,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      headline5: TextStyle(
        fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      headline6: TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: TextStyle(
        fontSize: AppConfig.dimen.defaultFontSize,
        color: Colors.white,
      ),
    ),
  );
}
