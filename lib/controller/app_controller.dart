import 'package:encrypt/encrypt.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:password_manager/controller/DataStatus.dart';
import 'package:password_manager/db/model/categories_model.dart';
import 'package:password_manager/db/model/generated_pass.dart';
import 'package:password_manager/db/model/password_model.dart';
import 'package:password_manager/db/store.dart';
import 'package:password_manager/envs.dart';
import 'package:password_manager/ui/auth/check_master_password.dart';
import 'package:password_manager/ui/auth/login_ui_page.dart';
import 'package:password_manager/ui/auth/master_pass_ui.dart';
import 'package:password_manager/ui/auth/verify_otp.dart';
import 'package:password_manager/ui/shared/snack_bar_helper.dart';
import 'package:password_manager/utils/encrtypt.dart';
import 'package:password_manager/utils/pass_generator.dart';
import 'package:password_manager/ext/ext.dart';

@lazySingleton
class AppController extends GetxController {
  final Store _store;

  AppController(this._store);

  var genPassword = GeneratedPassword(generatePassword(16)).obs;

  var categoryStatus =
      DataStatus<List<CategoriesModel>>(null, DataState.INIT).obs;
  // category cache data
  var cache = List<CategoriesModel>();

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

  void savePassword(
      CategoriesModel cat, String title, String userName, String pass) async {
    Encrypter encrypter = Get.find(tag: "ENCRYPT");

    var model = PasswordModel(
      companyName: title,
      userName: userName.encrypt(encrypter),
      password: pass.encrypt(encrypter),
      iconPath: "",
      categories: cat.uuid,
      strength: 10,
      updated: DateTime.now(),
      accessedOn: DateTime.now(),
    );

    // saved password
    var res = await _store.addPassword(model);
    if (res) {
      SnackBarHelper.showSuccess("Password added successfully");
      Get.back();
    } else {
      SnackBarHelper.showError("Something went wrong, please try again");
    }
  }

  // *********************************
  // ********** Categories ***********
  // *********************************
  void createCategory(String text) async {
    var model = CategoriesModel(name: text, icon: "");
    var res = await _store.addCategories(model);
    if (res) {
      SnackBarHelper.showSuccess("Category added successfully");
      //update list
      getAllData(force: true);
    } else {
      SnackBarHelper.showError("Something went wrong, please try again");
    }
  }

  void getAllData({force = false}) async {
    //if we have cache data, then we will show
    //and if we force, then it will read that data again
    if (!force && cache.isNotEmpty) {
      categoryStatus.update((val) {
        val.data = cache;
        val.state = DataState.LOADED;
      });

      return;
    }

    var cats = await _store.getCategories();

    var models = cats.docs.map((e) {
      return CategoriesModel.fromMap(e.data());
    }).toList();

    // save to the cache
    cache = models;

    //now update
    categoryStatus.update((val) {
      val.data = models;
      val.state = DataState.LOADED;
    });
  }
}
