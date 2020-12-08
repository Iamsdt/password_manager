import 'package:flutter/material.dart';

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
  );
}
