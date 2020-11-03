import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/ui/main/bottom_nav.dart';
import 'package:password_manager/ui/splash.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashUI(),
    );
  }
}
