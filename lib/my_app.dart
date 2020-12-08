import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/ui/splash.dart';
import 'package:password_manager/utils/theme/theme_data.dart';
import 'package:password_manager/utils/theme/themes.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Password Manager',
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      themeMode: ThemeService.theme,
      darkTheme: Themes.dark,
      theme: Themes.light,
      home: SplashUI(),
    );
  }
}
