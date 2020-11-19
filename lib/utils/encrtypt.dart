import 'package:encrypt/encrypt.dart';

//this will encrypt any string
//return Encrypted bytes as a Base64 representation
String encryptString(Encrypter encryptor, String text, {int length = 16}) {
  final iv = IV.fromLength(length);
  return encryptor.encrypt(text, iv: iv).base64;
}

//this will decrypt string
//input Base64 representation
// return string
String decryptString(Encrypter encryptor, String text, {int length = 16}) {
  final iv = IV.fromLength(length);
  return encryptor.decrypt64(text, iv: iv);
}

//create encryptor
Encrypter initEncryptor(String pass, String padding) {
  final key = Key.fromUtf8(pass);
  final encryptor = Encrypter(AES(key, mode: AESMode.sic, padding: padding));
  return encryptor;
}
