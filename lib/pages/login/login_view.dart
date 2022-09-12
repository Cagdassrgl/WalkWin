import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walk_win/core/components/buttons/custom_button.dart';
import 'package:walk_win/core/components/customTextField/custom_text_form_field.dart';
import 'package:walk_win/core/constants/app_consts.dart';
import 'package:walk_win/core/services/firebase_authentication.dart';
import 'package:walk_win/pages/login/login_view_model.dart';
import 'package:walk_win/pages/map/map_view.dart';
import 'package:walk_win/pages/register/register_view.dart';

final loginGlobalKey = GlobalKey<FormState>();

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    LoginViewModel viewModel = Get.put(LoginViewModel());
    Size size = MediaQuery.of(context).size;
    FirebaseAuthService authService = FirebaseAuthService();

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Form(
          key: loginGlobalKey,
          child: Wrap(
            children: [
              Image.asset(
                "assets/images/login_top.png",
                width: double.infinity,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  "Login Details",
                  style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              RadiusTextFormField(
                textEditingController: viewModel.email,
                hintText: "Email",
                validator: (value) {
                  if (value!.isEmpty) {
                    return '*required';
                  }
                  return null;
                },
                icon: const Icon(Icons.mail),
                iconInfoisValid: true,
                padding: const EdgeInsets.fromLTRB(40, 50, 40, 20),
              ),
              RadiusTextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return '*required';
                  }
                  return null;
                },
                textEditingController: viewModel.password,
                hintText: "Password",
                obsecureText: true,
                icon: const Icon(Icons.password),
                iconInfoisValid: true,
                padding: const EdgeInsets.fromLTRB(40, 20, 40, 10),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 300, bottom: 30),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(
                      color: AppColor.textButtonColor,
                    ),
                  ),
                ),
              ),
              Center(
                child: CustomButton.button(
                  size: size,
                  text: "SIGN IN",
                  onPressed: () {
                    if (!loginGlobalKey.currentState!.validate()) {
                      return;
                    }
                    authService
                        .signIn(viewModel.email.text, viewModel.password.text)
                        .then((value) {
                      if (value != null) {
                        Get.offAll(const MapPage());
                      }
                    });
                  },
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                  child: TextButton(
                    child: Text(
                      "Don't have an account? Register",
                      style: TextStyle(
                        color: AppColor.textButtonColor,
                      ),
                    ),
                    onPressed: () {
                      Get.to(const Register());
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
