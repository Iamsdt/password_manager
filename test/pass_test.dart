import 'package:password_manager/utils/pass_generator.dart';

void main() {
  var i = 0;
  while (i < 10) {
    var out = generatePassword(16);
    print(out);
    i++;
  }
}
