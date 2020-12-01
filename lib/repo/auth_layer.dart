import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthLayer {
  FirebaseAuth auth;

  AuthLayer() {
    auth = FirebaseAuth.instance;
  }

  void signupWithEmail(String email, String pass) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<UserCredential> loginEmail(String email, password) async {
    try {
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }

    return null;
  }

  void verifyUser(User user) async {
    if (!user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  void verifyEmailCOde(String code) async {
    try {
      await auth.checkActionCode(code);
      await auth.applyActionCode(code);
      auth.currentUser.reload();
    } on FirebaseAuthException catch (e, s) {
      if (e.code == 'invalid-action-code') {
        // todo code in not valid
        Fimber.e('The code is invalid.');
      }
      Fimber.e("Error on verify email code", ex: e, stacktrace: s);
    }
  }

  Future<UserCredential> googleSignin() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
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
