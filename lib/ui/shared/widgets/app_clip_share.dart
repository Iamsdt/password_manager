import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:password_manager/ui/shared/custom_shape.dart';
import 'package:password_manager/ext/ext.dart';
import 'package:password_manager/utils/image_const.dart';

class PassClipShare extends StatelessWidget {
  final double? firstCliperHight;
  final double? secondCliperHeight;
  final double? roundIconTop;

  const PassClipShare(
      {this.firstCliperHight,
      this.secondCliperHeight,
      this.roundIconTop,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: FirstCliper(),
          child: Container(
            height: firstCliperHight ?? context.heightPx * 0.2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[200]!, Colors.blueAccent],
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.4,
          child: ClipPath(
            clipper: SecondCliper(),
            child: Container(
              height: secondCliperHeight ?? context.heightPx * 0.2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[200]!, Colors.blueAccent],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: roundIconTop ?? context.heightPx * 0.07,
          left: 0,
          right: 0,
          child: Container(
            height: context.heightPx * 0.12,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  spreadRadius: 0.0,
                  color: Colors.black26,
                  offset: Offset(1.0, 10.0),
                  blurRadius: 20.0,
                ),
              ],
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              ImageConst.PASSWORD_ICON,
              width: 50,
              height: 60,
            ),
          ),
        ),
      ],
    );
  }
}
