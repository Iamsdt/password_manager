import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:password_manager/controller/DataStatus.dart';
import 'package:password_manager/db/model/notes.dart';
import 'package:password_manager/db/model/password_model.dart';
import 'package:password_manager/db/store.dart';
import 'package:password_manager/ui/shared/snack_bar_helper.dart';

@lazySingleton
class HomeController extends GetxController {
  static HomeController get to => Get.find();

  Store _store;

  HomeController(this._store);

  //focus node, to control text filed focus
  //reason of using here
  // it's using in a stateless widget
  //to prevent memory leak,
  // focus node needs to dispose
  var focusNode = FocusNode();

  var passwordModelStatus =
      DataStatus<List<PasswordModel>>([], DataState.INIT).obs;

  var notesModelStatus = DataStatus<List<NotesModel>>([], DataState.INIT).obs;

  List<PasswordModel> cache = [];

  void getAllData({force = false}) async {
    //if we have cache data, then we will show
    //and if we force, then it will read that data again
    if (!force && cache.isNotEmpty) {
      passwordModelStatus.update((val) {
        val?.data = cache;
        val?.state = DataState.LOADED;
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
      val?.data = models;
      val?.state = DataState.LOADED;
    });
  }

  // *********************************
  // ********** Notes ****************
  // *********************************

  void getNotes(String uuid) async {
    var cats = await _store.getNotes(uuid);

    var models = cats.docs.map((e) {
      return NotesModel.fromMap(e.data());
    }).toList();

    notesModelStatus.update((val) {
      val?.data = models;
      val?.state = DataState.LOADED;
    });
  }

  void saveNote(String uuid, String notes) async {
    var model = NotesModel(
      notes: notes,
      passwordUUID: uuid,
      updatedDate: DateTime.now(),
    );
    var res = await _store.addNote(model);

    if (res) {
      if (res) {
        SnackBarHelper.showSuccess("Note added successfully");
        //update list
        getNotes(uuid);
      } else {
        SnackBarHelper.showError("Something went wrong, please try again");
      }
    }
  }

  void updateNote(String uuid, String notes, String noteUUID) async {
    var model = NotesModel(
      notes: notes,
      passwordUUID: uuid,
      uuid: noteUUID,
      updatedDate: DateTime.now(),
    );
    var res = await _store.addNote(model, update: true);

    if (res) {
      if (res) {
        SnackBarHelper.showSuccess("Note updated successfully");
        //update list
        getNotes(uuid);
      } else {
        SnackBarHelper.showError("Something went wrong, please try again");
      }
    }
  }

  void deleteNote(String uuid) async {
    var res = await _store.deleteNote(uuid);
    if (res) {
      if (res) {
        SnackBarHelper.showSuccess("Note delete successfully");
        //update list
        getNotes(uuid);
      } else {
        SnackBarHelper.showError("Something went wrong, please try again");
      }
    }
  }

  //filter list
  void filterList(String value) {
    if (cache.isEmpty == true) {
      return;
    }

    if (value == "") {
      passwordModelStatus.update((val) {
        val?.data = cache;
        val?.state = DataState.LOADED;
      });
    }

    var filtered = cache
        .where((e) => e.companyName.toLowerCase().contains(value.toLowerCase()))
        .toList();

    passwordModelStatus.update((val) {
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
