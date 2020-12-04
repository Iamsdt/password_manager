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

  // ***********************************
  // ************PASSWORD***************
  // ***********************************

  Future<bool> addPassword(PasswordModel model) async {
    try {
      var pass = _firestore.collection(DbConstant.PASSWORD);
      await pass.doc(model.uuid).set(model.toMap());
      return true;
    } catch (e, s) {
      Fimber.e("Error on categories", ex: e, stacktrace: s);
      return false;
    }
  }

  Future<bool> updatePassword(PasswordModel model) async {
    try {
      var pass = _firestore.collection(DbConstant.PASSWORD);
      var options = SetOptions(merge: true);
      await pass.doc(model.uuid).set(model.toMap(), options);
      return true;
    } catch (e, s) {
      Fimber.e("Error on categories", ex: e, stacktrace: s);
      return false;
    }
  }

  Future<QuerySnapshot> getPassword() async {
    var pass = _firestore.collection(DbConstant.PASSWORD);
    return await pass.get();
  }

  Future<QuerySnapshot> getCategoryPassword(String categoryID) async {
    var pass = _firestore.collection(DbConstant.PASSWORD);
    return await pass.where("category", isEqualTo: categoryID).get();
  }

  void addNotes() {
    //
  }

  // ***********************************
  // ************CATEGORY***************
  // ***********************************

  Future<bool> addCategories(CategoriesModel model) async {
    try {
      var cat = _firestore.collection(DbConstant.CATEGORIES);
      await cat.doc(model.uuid).set(model.toMap());
      return true;
    } catch (e, s) {
      Fimber.e("Error on categories", ex: e, stacktrace: s);
      return false;
    }
  }

  Future<QuerySnapshot> getCategories() async {
    var cat = _firestore.collection(DbConstant.CATEGORIES);
    return await cat.get();
  }

  // ***********************************
  // ************CARDS***************
  // ***********************************

  // ***********************************
  // **********MASTER PASSWORD**********
  // ***********************************

  Future<bool> addMasterPassword(String pass) async {
    try {
      Encrypter encrypter = Get.find(tag: "ENCRYPT");
      var en = pass.encrypt(encrypter);

      var data = Map<String, String>();
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
    try {
      var data = await _firestore
          .collection(DbConstant.MASTERPASS)
          .doc("MasterPass")
          .get();

      return data.exists;
    } catch (e, s) {
      Fimber.e("Error on checking master password", ex: e, stacktrace: s);
      return false;
    }
  }
}
