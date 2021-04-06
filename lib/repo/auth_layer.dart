import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:password_manager/repo/auth_results.dart';
import 'package:password_manager/ui/shared/snack_bar_helper.dart';

@lazySingleton
class AuthLayer {
  FirebaseAuth? _auth;

  AuthLayer() {
    _auth = FirebaseAuth.instance;
  }

  Future<AuthResults> signupWithEmail(String email, String pass) async {
    try {
      var userCredential = await _auth?.createUserWithEmailAndPassword(
          email: email, password: pass);
      return AuthResults(userCredential, "", true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fimber.i('Weak password');
        return AuthResults(
            null, "This is a weak password, please use strong one", false);
      } else if (e.code == 'email-already-in-use') {
        Fimber.i('The account already exists for that email.');
        return AuthResults(
            null, "The account already exists for that email.", false);
      }
    }

    return AuthResults(null, "Something went wrong! please try again", false);
  }

  Future<AuthResults> loginEmail(String email, password) async {
    try {
      var userCredential = await _auth?.signInWithEmailAndPassword(
          email: email, password: password);
      return AuthResults(userCredential, "", true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fimber.i('No user found for that email.');
        return AuthResults(null, "No user found for that email.", false);
      } else if (e.code == 'wrong-password') {
        Fimber.i('Wrong password provided for that user.');
        return AuthResults(
            null, "Wrong password provided for that user.", false);
      }
    }

    return AuthResults(null, "Something went wrong! please try again", false);
  }

  //send verification email
  Future<bool> verifyUser() async {
    var user = _auth?.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      return true;
    }

    return false;
  }

  Future<void> recoverPassword(String email) async {
    return await _auth?.sendPasswordResetEmail(email: email);
  }

  Future<bool> verifyEmailCode(String code) async {
    try {
      await _auth?.checkActionCode(code);
      await _auth?.applyActionCode(code);
      await _auth?.currentUser?.reload();
      return true;
    } on FirebaseAuthException catch (e, s) {
      if (e.code == 'invalid-action-code') {
        Fimber.e('The code is invalid.');
        SnackBarHelper.showError("The code is invalid.");
      }
      Fimber.e("Error on verify email code", ex: e, stacktrace: s);
      return false;
    }
  }

  Future<AuthResults> googleSignin() async {
    GoogleSignInAuthentication? googleAuth;
    // Obtain the _auth details from the request
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      googleAuth = await googleUser?.authentication;
    } catch (e, s) {
      Fimber.e("Something went wrong on google account", ex: e, stacktrace: s);
      return AuthResults(null, "Something went wrong please try again?", false);
    }

    // Create a new credential
    final OAuthCredential? credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    var cred = AuthCredential(
      providerId: credential?.providerId ?? "",
      signInMethod: credential?.signInMethod ?? "",
    );

    // Once signed in, return the UserCredential
    try {
      var userCredential =
          await FirebaseAuth.instance.signInWithCredential(cred);
      return AuthResults(userCredential, "", true);
    } on FirebaseAuthException catch (e, s) {
      Fimber.e("Something went wrong on google firebase account creation",
          ex: e, stacktrace: s);
      var message = "";
      switch (e.code) {
        case "account-exists-with-different-credential":
          message = "Account already exists with different credential";
          break;
        case "invalid-credential":
          message = "Invalid credential, please provide correct one";
          break;
        case "operation-not-allowed":
          message = "Sorry operation not allowed, please try again";
          break;
        case "user-disabled":
          message = "User disabled, please contact with app provider";
          break;
        case "user-not-found":
          message = "User not found, please contact with app provider";
          break;
        case "wrong-password":
          message = "Wrong password, please provide correct password";
          break;
        case "invalid-verification-code":
          message = "Wrong password, please provide correct password";
          break;
        case "invalid-verification-id":
          message = "Invalid verification id, please try again";
          break;
        default:
          message = "Something went wrong";
          break;
      }
      return AuthResults(null, message, false);
    }
  }

// void loginWithFacebook() async {
//   final LoginResult result = await FacebookAuth.instance.login();

//   // Create a credential from the access token
//   final FacebookAuthCredential facebookAuthCredential =
//       FacebookAuthProvider.credential(result.accessToken.token);

//   // Once signed in, return the UserCredential
//   var res = await FirebaseAuth.instance
//       .signInWithCredential(facebookAuthCredential);
// }
}
