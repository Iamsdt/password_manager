import 'package:flutter/widgets.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:password_manager/repo/auth_layer.dart';
import 'package:password_manager/repo/auth_results.dart';
import 'package:password_manager/ui/shared/snack_bar_helper.dart';

@lazySingleton
class LoginController extends GetxController {
  AuthLayer _layer;

  LoginController(this._layer);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  var obscureText = true.obs;

  void login() {
    var email = emailController.text;
    var pass = passController.text;

    //this is not required
    // if (!Validator.isEmailValid(email)) {
    //   SnackBarHelper.showError("Please add valid email");
    //   return;
    // }

    _layer
        .loginEmail(email, pass)
        .then((value) => analysisLoginResponse(value))
        .catchError((error, s) {
      Fimber.e("Error on login", ex: error, stacktrace: s);
      closeExistingSnackBar();
      SnackBarHelper.showError("Something went wrong. please try again!");
    });
  }

  void analysisLoginResponse(AuthResults value) async {
    if (value.status) {
      //that's means it's successful
      SnackBarHelper.showSuccess("Login successful");
      //check user emil is verified or not
      var user = value.userCredential.user;
      if (user.emailVerified) {
        //goto next page
      } else {
        SnackBarHelper.showInfo("Please very email!");
        await user.sendEmailVerification();
        SnackBarHelper.showSuccess(
            "Sent verification email, please check your inbox");

        //go to verification ui
      }
    } else {
      SnackBarHelper.showError(value.message);
    }
  }

  void googleLogin() {
    _layer
        .googleSignin()
        .then((value) => analysisGoogleResponse(value))
        .catchError((e, s) {
      Fimber.e("Google sign in error", ex: e, stacktrace: s);
      closeExistingSnackBar();
      SnackBarHelper.showError("Something went wrong. please try again!");
    });
  }

  void analysisGoogleResponse(AuthResults value) async {
    if (value.status) {
      //that's means it's ok
      //go to next master pass page
      SnackBarHelper.showSuccess("Login successful");
    } else {
      SnackBarHelper.showError(value.message);
    }
  }

  void facebookLogin() {
    SnackBarHelper.showInfo(
        "Please use google sign in or email sign in options");
  }

  void showPassword() {
    obscureText.update((val) {
      val = !val;
    });
  }

  void closeExistingSnackBar() {
    if (Get.isSnackbarOpen) {
      Get.back();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }
}
