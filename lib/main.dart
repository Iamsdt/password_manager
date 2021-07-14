import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:password_manager/di/config_inject.dart';
import 'package:password_manager/envs.dart';
import 'package:password_manager/my_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:async';
import 'package:flutter/foundation.dart' show kDebugMode;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //load env variables
  await dotenv.load(fileName: ".env");

  // inject first
  configureDependencies();

  //init firebase
  await Firebase.initializeApp();

  //init fimber
  MyEnvironment.initLogger();

  //now init get storage
  await GetStorage.init();

  if (kDebugMode) {
    runApp(MyApp());
  } else {
    runZonedGuarded<Future<void>>(() async {
      runApp(MyApp());
    }, (error, stacktrace) {
      FirebaseCrashlytics.instance.recordError(error, stacktrace,
          printDetails: kDebugMode, fatal: false);
    });
  }
}
