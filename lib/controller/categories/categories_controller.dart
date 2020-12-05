import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:password_manager/controller/DataStatus.dart';
import 'package:password_manager/db/model/password_model.dart';
import 'package:password_manager/db/store.dart';

@lazySingleton
class CategoriesController extends GetxController {
  Store _store;

  CategoriesController(this._store);

  var passwordModelStatus =
      DataStatus<List<PasswordModel>>(null, DataState.INIT).obs;

  void getAllData(String categoryID) async {
    var cats = await _store.getCategoryPassword(categoryID);
    var models = cats.docs.map((e) {
      return PasswordModel.fromMap(e.data());
    }).toList();

    //now update
    passwordModelStatus.update((val) {
      val.data = models;
      val.state = DataState.LOADED;
    });
  }
}
