import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walk_win/core/components/buttons/custom_button.dart';
import 'package:walk_win/core/components/customTextField/custom_text_form_field.dart';
import 'package:walk_win/core/services/firebase_authentication.dart';
import 'package:walk_win/pages/login/login_view.dart';
import 'package:walk_win/pages/register/register_view_model.dart';

final registerGlobalKey = GlobalKey<FormState>();

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterViewModel viewModel = Get.put(RegisterViewModel());
    Size size = MediaQuery.of(context).size;
    FirebaseAuthService auth = FirebaseAuthService();

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Form(
          key: registerGlobalKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Wrap(
              children: [
                Image.asset(
                  "assets/images/login_top.png",
                  width: double.infinity,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    "Register Details",
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                RadiusTextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '*required';
                    }
                    return null;
                  },
                  textEditingController: viewModel.name,
                  hintText: "Name",
                  icon: const Icon(Icons.person),
                  iconInfoisValid: true,
                  padding: const EdgeInsets.fromLTRB(40, 30, 40, 5),
                ),
                RadiusTextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '*required';
                    }
                    return null;
                  },
                  textEditingController: viewModel.surname,
                  hintText: "Surname",
                  icon: const Icon(Icons.person),
                  iconInfoisValid: true,
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 5),
                ),
                RadiusTextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '*required';
                    }
                    return null;
                  },
                  textEditingController: viewModel.email,
                  hintText: "Email",
                  icon: const Icon(Icons.mail),
                  iconInfoisValid: true,
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 5),
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
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 30),
                ),
                Center(
                    child: CustomButton.button(
                  size: size,
                  text: "SIGN UP",
                  onPressed: () {
                    if (!registerGlobalKey.currentState!.validate()) {
                      return;
                    }
                    auth
                        .createUser(
                          viewModel.name.text,
                          viewModel.surname.text,
                          viewModel.email.text,
                          viewModel.password.text,
                        )
                        .then(
                          (value) => Get.off(const Login()),
                        );
                  },
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
