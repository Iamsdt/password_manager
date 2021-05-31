import 'package:flutter/material.dart';
import 'app_config.dart';

class ResponsiveStateless extends StatelessWidget {
  ResponsiveStateless({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? widget;

    // logic is here, is you use builder, then it will use builder everywhere
    if (builder(context) != null) {
      widget = builder(context);
      if (widget != null) return widget;
    }

    if (AppConfig.isDesktop) {
      widget = desktop(context) ?? widget;
      if (widget != null) return widget;
    }

    if (AppConfig.isTablet) {
      widget = tablet(context) ?? desktop(context);
      if (widget != null) return widget;
    }

    if (AppConfig.isMobile) {
      widget = mobile(context) ?? tablet(context) ?? desktop(context);
      if (widget != null) return widget;
    }
    return watch(context) ??
        mobile(context) ??
        tablet(context) ??
        desktop(context) ??
        builder(context)!;
  }

  Widget? builder(BuildContext context) => null;

  Widget? desktop(BuildContext context) => null;

  Widget? mobile(BuildContext context) => null;

  Widget? tablet(BuildContext context) => null;

  Widget? watch(BuildContext context) => null;
}

class ResponsiveStatefulState<T extends StatefulWidget> extends State<T> {
  @override
  Widget build(BuildContext context) {
    Widget? widget;

    // logic is here, is you use builder, then don't user others
    if (builder(context) != null) {
      widget = builder(context);
      if (widget != null) return widget;
    }

    if (AppConfig.isDesktop) {
      widget = desktop(context) ?? widget;
      if (widget != null) return widget;
    }

    // for tablet
    // if tablet is null then it will look for Desktop
    // even desktop is null then it will look for mobile
    // otherwise it will return default one
    if (AppConfig.isTablet) {
      widget = tablet(context) ?? desktop(context) ?? mobile(context);
      if (widget != null) return widget;
    }

    if (AppConfig.isMobile) {
      widget = mobile(context) ?? tablet(context) ?? desktop(context);
      if (widget != null) return widget;
    }

    return watch(context) ??
        mobile(context) ??
        tablet(context) ??
        desktop(context) ??
        builder(context)!;
  }

  Widget? builder(BuildContext context) => null;

  Widget? desktop(BuildContext context) => null;

  Widget? mobile(BuildContext context) => null;

  Widget? tablet(BuildContext context) => null;

  Widget? watch(BuildContext context) => null;
}
