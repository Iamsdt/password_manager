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
  String _special = "@#=+!£\$%&?[](){}?<>~";

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

  // final charCodes = List<int>.generate(length, (_) {
  //   int codeUnit;
  //
  //   switch (random.nextInt(3)) {
  //     case 0:
  //       codeUnit = random.nextInt(10) + 48; //numbers
  //       break;
  //     case 1:
  //       codeUnit = random.nextInt(26) + 65; //large caps
  //       break;
  //     case 2:
  //       codeUnit = random.nextInt(26) + 97; //small caps
  //       break;
  //     case 3:
  //       codeUnit = random.nextInt(26) + 97; //symbols
  //       break;
  //   }
  //
  //   return codeUnit;
  // });

  // return String.fromCharCodes(charCodes);
}
