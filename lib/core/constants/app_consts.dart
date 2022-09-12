import 'package:flutter/material.dart';

class AppColor {
  static Color buttonColor = const Color.fromARGB(255, 0, 43, 91);
  static Color textButtonColor = const Color.fromARGB(255, 37, 109, 133);
}

class FirebaseErrorCode {
  static String network = "network-request-failed";
  static String password = "wrong-password";
  static String email = "invalid-email";
  static String user = "user-not-found";
  static String manyRequest = "too-many-requests";
  static String emailAlreadyExists = "email-already-in-use";
}
