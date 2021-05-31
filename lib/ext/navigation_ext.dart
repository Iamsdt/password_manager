import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension NavigationExt on State {
  void nextPage(Widget screen) {
    Navigator.push(
      this.context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  void nextPageReplacement(Widget screen) {
    Navigator.pushReplacement(
      this.context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  void nextPageName(String name, {Object? objects}) {
    Navigator.pushNamed(
      this.context,
      name,
      arguments: objects,
    );
  }

  void nextPageNameReplacement(String name, {Object? objects}) {
    Navigator.pushReplacementNamed(
      this.context,
      name,
      arguments: objects,
    );
  }

  void back(String name, {dynamic results}) {
    Navigator.pop(this.context, results);
  }

  Future<dynamic> nextPageWaitForResult(Widget screen) async {
    return await Navigator.push(
      this.context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}

extension NavigationStatelessExt on StatelessWidget {
  void nextPage(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  void nextPageReplacement(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  void nextPageName(BuildContext context, String name, {Object? objects}) {
    Navigator.pushNamed(
      context,
      name,
      arguments: objects,
    );
  }

  void nextPageNameReplacement(BuildContext context, String name,
      {Object? objects}) {
    Navigator.pushReplacementNamed(
      context,
      name,
      arguments: objects,
    );
  }

  void back(BuildContext context, String name, {dynamic results}) {
    Navigator.pop(context, results);
  }

  Future<dynamic> nextPageWaitForResult(
      BuildContext context, Widget screen) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
