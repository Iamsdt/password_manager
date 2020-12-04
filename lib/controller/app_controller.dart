import 'package:encrypt/encrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:password_manager/db/model/generated_pass.dart';
import 'package:password_manager/db/model/password_model.dart';
import 'package:password_manager/db/store.dart';
import 'package:password_manager/envs.dart';
import 'package:password_manager/ui/auth/check_master_password.dart';
import 'package:password_manager/ui/auth/login_ui_page.dart';
import 'package:password_manager/ui/auth/master_pass_ui.dart';
import 'package:password_manager/ui/auth/verify_otp.dart';
import 'package:password_manager/utils/encrtypt.dart';
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

  //handle splash screen
  void handleSplashScreen() async {
    //before going to next PAGE INIT Encryptor
    Encrypter encrypter =
        initEncryptor(MyEnvironment.passKey, MyEnvironment.paddingKey);
    //put into GetX, so that it can be accessed from across the APP
    Get.put<Encrypter>(encrypter, tag: "ENCRYPT", permanent: true);

    var user = FirebaseAuth.instance.currentUser;

    //check user is null or not
    //if null goto login page
    if (user == null) {
      Get.to(LoginPageUI());
      return;
    }

    //check user email is verified or not
    //if not send to verify page
    if (!user.emailVerified) {
      await user.sendEmailVerification();
      Get.to(VerifyOTP());
    }

    // and check user added master pass or not
    // if yes, then send to check master pass page
    // if not send to setup master pass page
    var res = await _store.checkMasterPassword();
    Get.to(res ? CheckMasterPassUI() : MasterPassUI());
  }
}
