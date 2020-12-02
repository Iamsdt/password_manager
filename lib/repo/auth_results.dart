import 'package:firebase_auth/firebase_auth.dart';

class AuthResults {
  UserCredential userCredential;
  String message;
  bool status;

  AuthResults(this.userCredential, this.message, this.status);
}
