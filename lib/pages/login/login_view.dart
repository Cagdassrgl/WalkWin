import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:walk_win/core/components/login/login_view.dart';
import 'package:walk_win/core/services/firebase_authentication.dart';
import 'package:walk_win/pages/login/login_view_model.dart';

final box = GetStorage();
final FirebaseAuth auth = FirebaseAuth.instance;

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    LoginViewModel loginViewModel = Get.put(LoginViewModel());
    Size size = MediaQuery.of(context).size;
    FirebaseAuthService authService = FirebaseAuthService();

    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        color: Colors.white,
        child: LoginViewConst.loginView(size, loginViewModel, authService),
      ),
    );
  }
}
