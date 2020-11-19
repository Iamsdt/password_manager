import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:password_manager/di/config_inject.dart';
import 'package:password_manager/my_app.dart';

void main() async {
  //load env variables
  await DotEnv().load('.env');
  // inject first
  configureDependencies();
  //run app
  runApp(MyApp());
}
