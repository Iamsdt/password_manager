import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:password_manager/my_app.dart';

void main() async {
  await Firebase.initializeApp();
  //load env variables
  await DotEnv().load('.env');
  runApp(MyApp());
}
