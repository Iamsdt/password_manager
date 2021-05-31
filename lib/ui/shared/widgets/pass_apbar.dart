import 'package:flutter/material.dart';
import 'package:password_manager/ext/ext.dart';

// this will take 0.15 percent of the total height
class PassAppBar extends StatelessWidget {
  final double? height;
  const PassAppBar({this.height, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? context.heightPx * 0.15,
      width: context.widthPx,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue[200]!,
            Colors.blueAccent,
          ],
        ),
      ),
    );
  }
}
