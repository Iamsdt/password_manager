import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_fimber/flutter_fimber.dart';

class MyEnvironment {
  static String get passKey => dotenv.env['PASS'] ?? "";

  static void initLogger() {
    if (kDebugMode) {
      Fimber.plantTree(FimberTree(useColors: true));
      Fimber.plantTree(DebugBufferTree.elapsed());
    }
  }
}
