import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';

void logout() async {
  await FirebaseAuth.instance.signOut();
}

String createNonce(int length) {
  final random = Random.secure();
  final charCodes = List<int>.generate(length, (_) {
    int codeUnit;

    switch (random.nextInt(3)) {
      case 0:
        codeUnit = random.nextInt(10) + 48; //numbers
        break;
      case 1:
        codeUnit = random.nextInt(26) + 65; //small caps
        break;
      case 2:
        codeUnit = random.nextInt(26) + 97; //
        break;
    }

    return codeUnit;
  });

  return String.fromCharCodes(charCodes);
}
