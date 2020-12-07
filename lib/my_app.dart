import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/ui/splash.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Password Manager',
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashUI(),
    );
  }
}
