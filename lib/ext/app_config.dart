import 'package:flutter/material.dart';
import '../utils/dimension/dimension_desktop.dart';
import '../utils/dimension/dimension_mobile.dart';
import '../utils/dimension/dimension_tablet.dart';
import '../utils/dimension/dimensions.dart';

/// Class to initialize calculation for responsiveness
/// must be called when the app is started
class AppConfig {
  AppConfig({
    this.designScreenWidth = 392, //pixel 4 emulator
    this.designScreenHeight = 781, //pixel 4 emulator
    this.desktopChangePoint = 900,
    this.tabletChangePoint = 650,
    this.watchChangePoint = 300,
  });

  final double desktopChangePoint;

  final double tabletChangePoint;

  final double watchChangePoint;

  /// the value of [screen width] of design given by [designer]
  int designScreenWidth;

  /// the value of [screen height] of design given by [designer]
  int designScreenHeight;

  /// [width] of current device
  static double _screenWidth = 1.0;

  /// [height] of current device
  static double _screenHeight = 1.0;

  /// value to initialize [fontSize]
  static double textMultiplier = 1.0;

  /// value to initialize [image sizes]
  static double imageSizeMultiplier = 1.0;

  /// value to initialize [height] values
  static double heightMultiplier = 1.0;

  /// value to initialize [width] values
  static double widthMultiplier = 1.0;

  /// value to get information about [orientation]
  static bool isPortrait = true;

  /// value to get information about [portrait] in in [mobile] or [not]
  static bool isMobilePortrait = false;

  static DeviceType deviceType = DeviceType.MOBILE;

  static BaseDimension dimen = BaseDimension();

  /// the method to initialize [SizeConfig] for responsive calculation
  void init(BuildContext context, BoxConstraints constraints,
      Orientation orientation) {
    if (orientation == Orientation.portrait) {
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      isPortrait = true;
      if (_screenWidth < 450) {
        isMobilePortrait = true;
      }
    } else {
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;
      isPortrait = false;
      isMobilePortrait = false;
    }

    imageSizeMultiplier = heightMultiplier = _screenHeight / designScreenHeight;
    widthMultiplier = textMultiplier = _screenWidth / designScreenWidth;

    if (_screenWidth >= desktopChangePoint) {
      // this is desktop
      deviceType = DeviceType.DESKTOP;
      dimen = DextopDimension();
    } else if (_screenWidth < desktopChangePoint &&
        _screenWidth >= tabletChangePoint) {
      //this is tablet
      deviceType = DeviceType.TABLET;
      dimen = TabletDimension();
    } else if (_screenWidth < tabletChangePoint &&
        _screenWidth >= watchChangePoint) {
      //this is mobile
      deviceType = DeviceType.MOBILE;
      dimen = MobileDimension();
    } else if (_screenWidth < watchChangePoint) {
      // this is watch
      deviceType = DeviceType.WATCH;
    }
  }

  // device types
  static bool get isMobile => deviceType == DeviceType.MOBILE;
  static bool get isTablet => deviceType == DeviceType.TABLET;
  static bool get isWatch => deviceType == DeviceType.WATCH;
  static bool get isDesktop => deviceType == DeviceType.DESKTOP;
}

enum DeviceType { MOBILE, WATCH, TABLET, DESKTOP }
