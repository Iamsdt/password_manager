import 'package:get/get.dart';

import 'app_config.dart';

extension Responsive on num {
  /// [getter] to get [responsive height] according to device height
  double get h => AppConfig.heightMultiplier * this;

  /// [getter] to get [responsive width] according to device width
  double get w => AppConfig.widthMultiplier * this;

  /// [getter] to get [responsive fontSize] according to device width
  double get fontSize => AppConfig.textMultiplier * this;

  double minHeight(double minHeight) {
    if (minHeight > h) {
      return minHeight;
    }
    return h;
  }

  double minWidth(double minWidth) {
    if (minWidth > w) {
      return minWidth;
    }
    return w;
  }

  double minFontSize(double minSize) {
    if (minSize > fontSize) {
      return minSize;
    }
    return fontSize;
  }
}
