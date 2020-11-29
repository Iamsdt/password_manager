import 'package:encrypt/encrypt.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:password_manager/db/model/generated_pass.dart';
import 'package:password_manager/db/model/password_model.dart';
import 'package:password_manager/db/store.dart';
import 'package:password_manager/utils/pass_generator.dart';
import 'package:password_manager/ext/ext.dart';

@lazySingleton
class AppController extends GetxController {
  final Store _store;

  AppController(this._store);

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

  void savePassword(String title, String userName, String pass) {
    Encrypter encrypter = Get.find(tag: "ENCRYPT");

    var model = PasswordModel(
      companyName: title,
      userName: userName.encrypt(encrypter),
      password: pass.encrypt(encrypter),
      iconPath: "",
      categories: "",
      updated: DateTime.now(),
      accessedOn: DateTime.now(),
    );

    // saved password
    _store.addPassword(model);
  }
}
