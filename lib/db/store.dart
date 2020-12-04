import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:password_manager/db/db_constant.dart';
import 'package:password_manager/db/model/categories_model.dart';
import 'package:password_manager/db/model/password_model.dart';
import 'package:password_manager/ui/shared/snack_bar_helper.dart';
import 'package:password_manager/ext/ext.dart';

@lazySingleton
class Store {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void addPassword(PasswordModel model) {
    var pass = _firestore.collection(DbConstant.PASSWORD);
    pass.add(model.toMap()).then((value) {
      SnackBarHelper.showSuccess("Added Successfully");
    }).catchError((error) {
      SnackBarHelper.showError("Something went wrong, please try again");
    });
  }

  void addCategories(CategoriesModel model) {
    var pass = _firestore.collection(DbConstant.PASSWORD);
    pass.add(model.toMap()).then((value) {
      SnackBarHelper.showSuccess("Added Successfully");
    }).catchError((error) {
      SnackBarHelper.showError("Something went wrong, please try again");
    });
  }

  void addNotes() {
    //
  }

  Future<bool> addMasterPassword(String pass) async {
    try {
      Encrypter encrypter = Get.find(tag: "ENCRYPT");
      var en = pass.encrypt(encrypter);

      var data = Map();
      data['psssword'] = en;

      await _firestore
          .collection(DbConstant.MASTERPASS)
          .doc("MasterPass")
          .set(data);

      return true;
    } catch (e, s) {
      Fimber.e("Error on add master pass", ex: e, stacktrace: s);
      //if error then return false
      return false;
    }
  }

  Future<DocumentSnapshot> getMasterPass() async {
    return await _firestore
        .collection(DbConstant.MASTERPASS)
        .doc("MasterPass")
        .get();
  }

  Future<bool> checkMasterPassword() async {
    var data = await _firestore
        .collection(DbConstant.MASTERPASS)
        .doc("MasterPass")
        .get();

    return data.exists;
  }
}
