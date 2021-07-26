import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:password_manager/db/store.dart';
import 'package:password_manager/repo/auth_layer.dart';
import 'package:password_manager/repo/auth_results.dart';
import 'package:password_manager/ui/auth/check_master_password.dart';
import 'package:password_manager/ui/auth/login_ui_page.dart';
import 'package:password_manager/ui/auth/master_pass_ui.dart';
import 'package:password_manager/ui/auth/verify_otp.dart';
import 'package:password_manager/ui/shared/snack_bar_helper.dart';

@lazySingleton
class LoginController extends GetxController {
  AuthLayer _layer;
  Store _store;

  LoginController(this._layer, this._store);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

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
      var user = value.userCredential?.user;
      if (user?.emailVerified == true) {
        //goto next page
        nextPage();
      } else {
        SnackBarHelper.showInfo("Please very email!");
        await user?.sendEmailVerification();
        Get.to(VerifyOTP());
        SnackBarHelper.showSuccess(
            "Sent verification email, please check your inbox");
        //go to verification ui
      }
    } else {
      SnackBarHelper.showError(value.message);
    }
  }

  void recoverPassword() async {
    var email = emailController.text;
    try {
      await _layer.recoverPassword(email);
      Get.off(LoginPageUI());
      SnackBarHelper.showSuccess("Sent recovery email, successfully");
    } catch (e, s) {
      if (e == 'user-not-found') {
        SnackBarHelper.showError(
            "User not found with this email adress, Plese use correct one");
      }

      Fimber.e("Error on recover email", ex: e, stacktrace: s);
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
      nextPage();
    } else {
      SnackBarHelper.showError(value.message);
    }
  }

  void facebookLogin() {
    SnackBarHelper.showInfo(
        "Please use google sign in or email sign in options");
  }

  void closeExistingSnackBar() {
    if (Get.isSnackbarOpen == true) {
      Get.back();
    }
  }

  Future<bool> checkMasterPassExists() async {
    //show loading dialog
    Get.dialog(
      Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );

    var res = await _store.checkMasterPassword();

    //hide loading dialog
    //check dialog is showing or user close
    if (Get.isDialogOpen == true) {
      Get.back();
    }

    return res;
  }

  void verify() async {
    var user = FirebaseAuth.instance.currentUser;
    //reload user
    await user?.reload();
    //now check user email is verified
    if (user != null && user.emailVerified) {
      //then go to next page
      nextPage();
    } else {
      SnackBarHelper.showError(
          "Account not verified yet! Please verify your account");
    }
  }

  void nextPage() async {
    var res = await checkMasterPassExists();
    if (res) {
      Get.to(() => CheckMasterPassUI());
    } else {
      Get.to(() => MasterPassUI());
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }
}
