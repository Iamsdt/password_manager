import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:password_manager/controller/DataStatus.dart';
import 'package:password_manager/db/model/password_model.dart';
import 'package:password_manager/db/store.dart';

@lazySingleton
class HomeController extends GetxController {

  static HomeController get to => Get.find();

  Store _store;

  HomeController(this._store);

  var passwordModelStatus =
      DataStatus<List<PasswordModel>>(null, DataState.INIT).obs;

  var cache = List<PasswordModel>();

  void getAllData({force = false}) async {
    //if we have cache data, then we will show
    //and if we force, then it will read that data again
    if (!force && cache.isNotEmpty) {
      passwordModelStatus.update((val) {
        val.data = cache;
        val.state = DataState.LOADED;
      });

      return;
    }

    var cats = await _store.getPassword();

    var models = cats.docs.map((e) {
      return PasswordModel.fromMap(e.data());
    }).toList();

    // save to the cache
    cache = models;

    //now update
    passwordModelStatus.update((val) {
      val.data = models;
      val.state = DataState.LOADED;
    });
  }
}
