import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:password_manager/repo/auth_layer.dart';

@lazySingleton
class SignupController extends GetxController {
  AuthLayer _layer;

  SignupController(this._layer);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  var obscureText = true.obs;

  void signup() {}

  void googleLogin() {}

  void facebookLogin() {}

  void showPassword() {
    obscureText.update((val) {
      val = !val;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }
}
