import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:password_manager/db/db_constant.dart';
import 'package:password_manager/db/model/password_model.dart';
import 'package:password_manager/ui/shared/snack_bar_helper.dart';

@lazySingleton
class Store {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addPassword(PasswordModel model) {
    var pass = firestore.collection(DbConstant.PASSWORD);
    pass.add(model.toMap()).then((value) {
      SnackBarHelper.showSuccess("Added Successfully");
    }).catchError((error){
      SnackBarHelper.showError("Something went wrong, please try again");
    });
  }
}
