import 'package:password_manager/utils/pass_generator.dart';

void main() {
  var i = 0;
  while (i < 10) {
    var out = generatePassword(16);
    print(out);
    i++;
  }

  //prefix text
  print(generatePassword(16, prefix: "Hello"));
  print(generatePassword(16, prefix: "HI"));
  print(generatePassword(10, prefix: "DM"));
}
