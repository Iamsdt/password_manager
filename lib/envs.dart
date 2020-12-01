import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_fimber/flutter_fimber.dart';

//where ever it required,
//inject there

class MyEnvironment {
  static bool _isLive = false;
  static String get passKey => DotEnv().env['PASS'];

  static String get paddingKey => DotEnv().env['PADDING'];

  //get length for generating IV
  static String get length => DotEnv().env['LEN'];

  static void initLogger() {
    if (!_isLive) {
      Fimber.plantTree(FimberTree(useColors: true));
      Fimber.plantTree(DebugBufferTree.elapsed());
    }
  }
}
