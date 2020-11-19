import 'package:get/state_manager.dart';
import 'package:injectable/injectable.dart';
import 'package:password_manager/db/model/generated_pass.dart';
import 'package:password_manager/utils/pass_generator.dart';

@lazySingleton
class AppController extends GetxController {
  var genPassword = GeneratedPassword(generatePassword(16)).obs;

  @override
  void onInit() {
    super.onInit();
  }

  void updatePassword(
      {int length = 16,
      bool isLowerCase = true,
      bool isUpperCase = true,
      bool isNumbers = true,
      bool isSpecial = true}) {
    var pass = generatePassword(
      length,
      isLowerCase: isLowerCase,
      isUpperCase: isUpperCase,
      isNumbers: isNumbers,
      isSpecial: isSpecial,
    );

    print(pass);

    genPassword.update((val) {
      val.pass = pass;
      val.isLowerCase = isLowerCase;
      val.isUpperCase = isUpperCase;
      val.isNumbers = isNumbers;
      val.isSpecial = isSpecial;
    });
  }
}
