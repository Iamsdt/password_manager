import 'package:flutter/widgets.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:password_manager/repo/auth_layer.dart';
import 'package:password_manager/repo/auth_results.dart';
import 'package:password_manager/ui/auth/master_pass_ui.dart';
import 'package:password_manager/ui/auth/verify_otp.dart';
import 'package:password_manager/ui/shared/snack_bar_helper.dart';

@lazySingleton
class SignupController extends GetxController {
  AuthLayer _layer;

  SignupController(this._layer);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  void signup() {
    var email = emailController.text;
    var pass = passController.text;

    _layer
        .signupWithEmail(email, pass)
        .then((value) => analysisSingupResponse(value))
        .catchError((error, s) {
      Fimber.e("Error on login", ex: error, stacktrace: s);
      closeExistingSnackBar();
      SnackBarHelper.showError("Something went wrong. please try again!");
    });
  }

  void analysisSingupResponse(AuthResults value) async {
    if (value.status) {
      //that's means it's successful
      SnackBarHelper.showSuccess("Account created successful");
      //check user emil is verified or not
      var user = value.userCredential.user;
      if (user.emailVerified) {
        //goto next page
        nextPage();
      } else {
        SnackBarHelper.showInfo("Please very email!");
        await user.sendEmailVerification();
        SnackBarHelper.showSuccess(
            "Sent verification email, please check your inbox");

        Get.to(VerifyOTP());
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
      SnackBarHelper.showSuccess("Account created successful");
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
    if (Get.isSnackbarOpen) {
      Get.back();
    }
  }

  void nextPage() async {
    Get.to(MasterPassUI());
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }
}
