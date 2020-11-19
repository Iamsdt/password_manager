import 'package:get/state_manager.dart';
import 'package:password_manager/utils/pass_generator.dart';

class AppController extends GetxController {
  var genPassword = generatePassword(16).obs;

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
    genPassword.update((val) {
      val = generatePassword(length,
          isLowerCase: isLowerCase,
          isUpperCase: isUpperCase,
          isNumbers: isNumbers,
          isSpecial: isSpecial);
    });
  }
}
