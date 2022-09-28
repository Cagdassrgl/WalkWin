import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walk_win/core/components/register/register_view.dart';
import 'package:walk_win/core/services/firebase_authentication.dart';
import 'package:walk_win/pages/map/map_view_model.dart';
import 'package:walk_win/pages/register/register_view_model.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterViewModel registerViewModel = Get.put(RegisterViewModel());
    MapViewModel mapViewModel = Get.put(MapViewModel());
    Size size = MediaQuery.of(context).size;
    FirebaseAuthService authService = FirebaseAuthService();

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: RegisterViewConst.registerView(
                size, registerViewModel, mapViewModel, authService)),
      ),
    );
  }
}
