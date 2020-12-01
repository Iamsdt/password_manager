import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:password_manager/repo/auth_layer.dart';

@lazySingleton
class LoginController extends GetxController {
  AuthLayer _layer;

  LoginController(this._layer);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  var obsecureText = true.obs;

  void login() {}

  void googleLogin() {}

  void facebookLogin() {}

  void showPassword() {
    obsecureText.update((val) {
      val = !val;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }
}
