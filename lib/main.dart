import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:password_manager/controller/app_controller.dart';
import 'package:password_manager/di/config_inject.dart';
import 'package:password_manager/envs.dart';
import 'package:password_manager/my_app.dart';

void main() async {
  //load env variables
  await DotEnv().load('.env');
  // inject first
  configureDependencies();

  //init firebase
  await Firebase.initializeApp();

  //init fimber
  MyEnvironment.initLogger();

  //now init get storage
  await GetStorage.init();

  // ScreenUtil.init(designSize: Size(750, 1334), allowFontScaling: false);

  //run app
  runApp(MyApp());
}
