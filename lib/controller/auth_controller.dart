// import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// // import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// class AuthController extends GetxController {
//   FirebaseAuth auth;

//   @override
//   void onInit() {
//     auth = FirebaseAuth.instance;
//     super.onInit();
//   }

//   void signupWithEmail() async {
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(
//               email: "barry.allen@example.com",
//               password: "SuperSecretPassword!");
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         print('The password provided is too weak.');
//       } else if (e.code == 'email-already-in-use') {
//         print('The account already exists for that email.');
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   void loginEmail() async {
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(
//               email: "barry.allen@example.com",
//               password: "SuperSecretPassword!");
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         print('No user found for that email.');
//       } else if (e.code == 'wrong-password') {
//         print('Wrong password provided for that user.');
//       }
//     }
//   }

//   void verifyUser(User user) async {
//     if (!user.emailVerified) {
//       await user.sendEmailVerification();
//     }
//   }

//   void verifyEmailCOde(String code) async {
//     try {
//       await auth.checkActionCode(code);
//       await auth.applyActionCode(code);
//       auth.currentUser.reload();
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'invalid-action-code') {
//         print('The code is invalid.');
//       }
//     }
//   }

//   void googleSignin() async {
//     final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

//     // Obtain the auth details from the request
//     final GoogleSignInAuthentication googleAuth =
//         await googleUser.authentication;

//     // Create a new credential
//     final GoogleAuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     // Once signed in, return the UserCredential
//     var res = await FirebaseAuth.instance.signInWithCredential(credential);
//   }

//   // void loginWithFacebook() async {
//   //   final LoginResult result = await FacebookAuth.instance.login();

//   //   // Create a credential from the access token
//   //   final FacebookAuthCredential facebookAuthCredential =
//   //       FacebookAuthProvider.credential(result.accessToken.token);

//   //   // Once signed in, return the UserCredential
//   //   var res = await FirebaseAuth.instance
//   //       .signInWithCredential(facebookAuthCredential);
//   // }

//   // void loginWithApple() async {
//   //   if (!Platform.isIOS) {
//   //     return;
//   //   }

//   //   final nonce = createNonce(32);

//   //   final nativeAppleCred = await SignInWithApple.getAppleIDCredential(
//   //     scopes: [
//   //       AppleIDAuthorizationScopes.email,
//   //       AppleIDAuthorizationScopes.fullName,
//   //     ],
//   //     nonce: sha256.convert(utf8.encode(nonce)).toString(),
//   //   );

//   //   var oauthCred = OAuthCredential(
//   //     providerId: "apple.com",
//   //     // MUST be "apple.com"
//   //     signInMethod: "oauth",
//   //     // MUST be "oauth"
//   //     accessToken: nativeAppleCred.identityToken,
//   //     // propagate Apple ID token to BOTH accessToken and idToken parameters
//   //     idToken: nativeAppleCred.identityToken,
//   //     rawNonce: nonce,
//   //   );

//   //   //todo handle
//   //   await FirebaseAuth.instance.signInWithCredential(oauthCred);
//   // }

//   // void verifyPhoneNumber(String phone, String smsCode) async {
//   //   var number = await FirebaseAuth.instance.verifyPhoneNumber(
//   //     phoneNumber: phone,
//   //     verificationCompleted: (PhoneAuthCredential credential) async {
//   //       await auth.signInWithCredential(credential);
//   //     },
//   //     verificationFailed: (FirebaseAuthException e) async {
//   //       if (e.code == 'invalid-phone-number') {
//   //         print('The provided phone number is not valid.');
//   //       }
//   //     },
//   //     codeSent: (String verificationId, int resendToken) async {
//   //       // Create a PhoneAuthCredential with the code
//   //       PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
//   //           verificationId: verificationId, smsCode: smsCode);

//   //       // Sign the user in (or link) with the credential
//   //       await auth.signInWithCredential(phoneAuthCredential);
//   //     },
//   //     codeAutoRetrievalTimeout: (String verificationId) {},
//   //   );
//   // }
// }
