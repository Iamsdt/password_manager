import 'dart:math';

String generatePassword(int length,
    {bool isLowerCase = true,
    bool isUpperCase = true,
    bool isNumbers = true,
    bool isSpecial = true}) {
  //all the hardcoded characters
  String _lowercase = "abcdefghijklmnopqrstuvwxyz";
  String _uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  String _numbers = "0123456789";
  String _special = "@#=-+!£\$%&?[](){}?<>~";

  //now add all the characters
  String chars = "";
  chars += (isLowerCase ? _lowercase : '');
  chars += (isUpperCase ? _uppercase : '');
  chars += (isNumbers ? _numbers : '');
  chars += (isSpecial ? _special : '');

  //create secure random
  var random = Random.secure();

  //now generate string
  return List.generate(length, (index) => chars[random.nextInt(chars.length)])
      .join();
}
