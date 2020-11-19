import 'package:flutter_dotenv/flutter_dotenv.dart';

//where ever it required,
//inject there

class MyEnvironment {
  static String get passKey => DotEnv().env['PASS'];

  static String get paddingKey => DotEnv().env['PADDING'];

  //get length for generating IV
  static String get length => DotEnv().env['LEN'];
}
