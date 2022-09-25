import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:walk_win/core/services/firebase_authentication.dart';

class LoginViewModel extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final FirebaseAuthService _authService = FirebaseAuthService();

  void signIn() {
    try {
      _authService.signIn(email.text, password.text);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void signOut() {
    _authService.signOut();
  }

  void resetPassword() {
    if (email.text.isNotEmpty) {
      _authService.resetPassword(email.text);
      Fluttertoast.showToast(msg: "Please check your inbox");
    } else {
      Fluttertoast.showToast(msg: "Please enter an email");
    }
  }
}
