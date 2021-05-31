import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/utils/encrtypt.dart';

extension TextS on String {
  Widget toText({TextStyle style = const TextStyle()}) {
    return Text(
      this,
      style: style,
    );
  }
}

extension Nums on String {
  // to int
  int toInt() => int.parse(this.trim());

  //this double
  double toDouble() => double.parse(this.trim());
}

// extension LocalX on String {
//   String translate() => AppLocalizations.of(Get.context).translate(this);
// }

//encryption
extension EncryptS on String {
  String encrypt(Encrypter encrypter) => encryptString(encrypter, this);
  String decrypt(Encrypter encrypter) => decryptString(encrypter, this);
}
