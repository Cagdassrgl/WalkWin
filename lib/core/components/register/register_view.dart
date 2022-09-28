import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:walk_win/core/components/buttons/custom_button.dart';
import 'package:walk_win/core/components/customTextField/custom_text_form_field.dart';
import 'package:walk_win/core/constants/app_consts.dart';
import 'package:walk_win/core/services/firebase_authentication.dart';
import 'package:walk_win/pages/login/login_view.dart';
import 'package:walk_win/pages/map/map_view_model.dart';
import 'package:walk_win/pages/register/register_view_model.dart';

class RegisterViewConst {
  static Widget registerView(
    Size size,
    RegisterViewModel registerViewModel,
    MapViewModel mapViewModel,
    FirebaseAuthService authService,
  ) {
    return Wrap(
      children: [
        Image.asset(
          "assets/images/login_top.png",
          width: double.infinity,
          height: size.height * 0.25,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 30, top: 20),
          child: Text(
            "Register Details",
            style: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        RadiusTextFormField(
          textEditingController: registerViewModel.name,
          hintText: HintText.name,
          icon: const Icon(Icons.person),
          iconInfoisValid: true,
          padding: const EdgeInsets.fromLTRB(40, 30, 40, 5),
        ),
        RadiusTextFormField(
          textEditingController: registerViewModel.username,
          hintText: HintText.username,
          icon: const Icon(Icons.person),
          iconInfoisValid: true,
          padding: const EdgeInsets.fromLTRB(40, 10, 40, 5),
        ),
        RadiusTextFormField(
          textEditingController: registerViewModel.email,
          hintText: HintText.email,
          icon: const Icon(Icons.mail),
          iconInfoisValid: true,
          padding: const EdgeInsets.fromLTRB(40, 10, 40, 5),
        ),
        RadiusTextFormField(
          textEditingController: registerViewModel.password,
          hintText: HintText.password,
          obsecureText: true,
          icon: const Icon(Icons.password),
          iconInfoisValid: true,
          padding: const EdgeInsets.fromLTRB(40, 10, 40, 30),
        ),
        Center(
            child: CustomButton.button(
          size: size,
          text: AppText.signUp,
          onPressed: () async {
            if (registerViewModel.name.text.isEmpty &&
                registerViewModel.username.text.isEmpty &&
                registerViewModel.email.text.isEmpty &&
                registerViewModel.password.text.isEmpty) {
              Fluttertoast.showToast(msg: "Please enter every field.");
            } else {
              var value = await authService.createUser(
                  registerViewModel.name.text,
                  registerViewModel.username.text,
                  registerViewModel.email.text,
                  registerViewModel.password.text,
                  mapViewModel.totalDistance);

              if (value != null) {
                Get.off(const Login());
              } else {
                Fluttertoast.showToast(msg: "Failed to create user.");
              }
            }
          },
        )),
      ],
    );
  }
}
