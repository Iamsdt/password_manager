import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/ui/splash.dart';
import 'package:password_manager/utils/theme/theme_data.dart';
import 'package:password_manager/utils/theme/themes.dart';

import 'ext/app_config.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            AppConfig(
              designScreenWidth: 392,
              designScreenHeight: 781,
            ).init(context, constraints, orientation);
            return GetMaterialApp(
              title: 'Password Manager',
              debugShowCheckedModeBanner: false,
              showPerformanceOverlay: false,
              themeMode: ThemeService.theme,
              darkTheme: Themes.dark,
              theme: Themes.light,
              home: SplashUI(),
            );
          },
        );
      },
    );
  }
}
