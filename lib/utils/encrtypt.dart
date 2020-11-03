import 'package:encrypt/encrypt.dart';

String encryptString(Encrypter encryptor, String text, int length) {
  final iv = IV.fromLength(length);
  return encryptor.encrypt(text, iv: iv).base64;
}

String decryptString(Encrypter encryptor, String text, int length) {
  final iv = IV.fromLength(length);
  return encryptor.decrypt64(text, iv: iv);
}

Encrypter initEncryptor(String pass, String padding) {
  final key = Key.fromUtf8(pass);
  final encryptor = Encrypter(AES(key, mode: AESMode.cbc, padding: padding));
  return encryptor;
}
