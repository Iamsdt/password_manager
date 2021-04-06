import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_fimber/flutter_fimber.dart';

class MyEnvironment {
  static bool _isLive = false;
  static String get passKey => env['VAR_NAME'] ?? "";

  static void initLogger() {
    if (!_isLive) {
      Fimber.plantTree(FimberTree(useColors: true));
      Fimber.plantTree(DebugBufferTree.elapsed());
    }
  }
}
