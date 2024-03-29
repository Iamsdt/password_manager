import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:password_manager/controller/DataStatus.dart';
import 'package:password_manager/controller/home/home_controller.dart';
import 'package:password_manager/db/model/categories_model.dart';
import 'package:password_manager/db/model/generated_pass.dart';
import 'package:password_manager/db/model/password_model.dart';
import 'package:password_manager/db/store.dart';
import 'package:password_manager/ext/ext.dart';
import 'package:password_manager/ui/shared/snack_bar_helper.dart';
import 'package:password_manager/utils/pass_generator.dart';
import 'package:password_manager/utils/utils.dart';

@lazySingleton
class AppController extends GetxController {
  static AppController get to => Get.find(tag: "APP");

  final Store _store;

  AppController(this._store);

  //controll focus for category search text field
  //explanination on *** home_controller.dart ***
  var focusNode = FocusNode();

  var genPassword = GeneratedPassword(pass: generatePassword(16)).obs;

  var categoryStatus =
      DataStatus<List<CategoriesModel>>([], DataState.INIT).obs;
  // category cache data
  List<CategoriesModel> cache = [];

  @override
  void onInit() {
    getAllData();
    super.onInit();
  }

  void updatePassword(
      {int length = 16,
      bool isLowerCase = true,
      bool isUpperCase = true,
      bool isNumbers = true,
      bool isSpecial = true,
      String prefix = ""}) {
    var pass = generatePassword(
      length,
      isLowerCase: isLowerCase,
      isUpperCase: isUpperCase,
      isNumbers: isNumbers,
      isSpecial: isSpecial,
      prefix: prefix,
    );

    print(pass);

    genPassword.update((val) {
      if (val == null) return;
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
      strength: Utils.analysisPassword(pass),
      updated: DateTime.now(),
      accessedOn: DateTime.now(),
    );

    // saved password
    var res = await _store.addPassword(model);
    if (res) {
      Get.back();
      SnackBarHelper.showSuccess("Password added successfully");
      HomeController.to.getAllData(force: true);
    } else {
      SnackBarHelper.showError("Something went wrong, please try again");
    }
  }

  Future<bool> updateSavePassword(PasswordModel model) async {
    Encrypter encrypter = Get.find(tag: "ENCRYPT");

    var res = await _store.addPassword(
      model.copyWith(
        userName: model.userName.encrypt(encrypter),
        password: model.password.encrypt(encrypter),
      ),
      update: true,
    );

    if (res) {
      SnackBarHelper.showSuccess("Password deleted successfully");
      //update list
      HomeController.to.getAllData(force: true);
    } else {
      SnackBarHelper.showError("Something went wrong, please try again");
    }

    return res;
  }

  Future<bool> deletePassword(PasswordModel model) async {
    var uuid = model.uuid;
    if (uuid.isEmpty) return false;
    var res = await _store.deletePassword(uuid);
    if (res) {
      //update list
      HomeController.to.getAllData(force: true);
    } else {
      SnackBarHelper.showError("Something went wrong, please try again");
    }

    return res;
  }

  // *********************************
  // ****** UPDATE MASTER PASS *******
  // *********************************

  void updateMasterPassword(
      String current, String newPass, String confirmPass) async {
    //check both pass
    if (newPass != confirmPass) {
      SnackBarHelper.showError("Password not matched");
    }

    var res = await _store.getMasterPass();
    Encrypter encrypter = Get.find(tag: "ENCRYPT");
    var currentPass = current.encrypt(encrypter);

    if (res != currentPass) {
      SnackBarHelper.showError(
          "Current password did not match! Please try again?");

      return;
    }

    var result = await _store.addMasterPassword(newPass);
    Fimber.i("Master pass add result $result");
    if (!result) {
      SnackBarHelper.showError("Something went wrong, please try again");
    } else {
      SnackBarHelper.showSuccess("Master password updated successfully");
    }
  }

  // *********************************
  // ********** Categories ***********
  // *********************************
  void createCategory(String text) async {
    var model = CategoriesModel(name: text, icon: "");
    var res = await _store.addCategory(model);
    if (res) {
      SnackBarHelper.showSuccess("Category added successfully");
      //update list
      getAllData(force: true);
    } else {
      SnackBarHelper.showError("Something went wrong, please try again");
    }
  }

  void updateCategory(String text, String uuid) async {
    var model = CategoriesModel(name: text, icon: "", uuid: uuid);
    var res = await _store.addCategory(model, update: true);
    if (res) {
      SnackBarHelper.showSuccess("Category updated successfully");
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
        val?.data = cache;
        val?.state = DataState.LOADED;
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
      val?.data = models;
      val?.state = DataState.LOADED;
    });
  }

  Future<bool> deleteCategory(String uuid) async {
    var res1 = await _store.deleteCategory(uuid);
    var res2 = await _store.deleteCategoryPasswords(uuid);
    if (res1 && res2) {
      //update list
      getAllData(force: true);
    } else {
      SnackBarHelper.showError("Something went wrong, please try again");
    }

    return res1 && res2;
  }

  //filter categories list
  void filterList(String value) {
    if (cache.isEmpty == true) {
      return;
    }

    if (value == "") {
      categoryStatus.update((val) {
        val?.data = cache;
        val?.state = DataState.LOADED;
      });
    }

    var filtered = cache
        .where((e) => e.name.toLowerCase().contains(value.toLowerCase()))
        .toList();

    categoryStatus.update((val) {
      val?.data = filtered;
      val?.state = DataState.LOADED;
    });
  }

  void removeFocus() {
    focusNode.unfocus();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}
