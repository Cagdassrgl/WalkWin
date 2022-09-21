import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:walk_win/core/components/buttons/custom_button.dart';
import 'package:walk_win/core/components/customTextField/custom_text_form_field.dart';
import 'package:walk_win/core/constants/app_consts.dart';
import 'package:walk_win/core/services/firebase_authentication.dart';
import 'package:walk_win/pages/dashboard/dashboard_view.dart';
import 'package:walk_win/pages/login/login_view_model.dart';
import 'package:walk_win/pages/register/register_view.dart';

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
        color: Colors.white,
        child: Wrap(
          children: [
            Image.asset(
              "assets/images/login_top.png",
              width: double.infinity,
            ),
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.1),
              child: Text(
                "Login Details",
                style: GoogleFonts.arsenal(
                  textStyle: TextStyle(
                    color: AppColor.textButtonColor,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            RadiusTextFormField(
              textEditingController: loginViewModel.email,
              hintText: "Email*",
              icon: const Icon(Icons.mail),
              iconInfoisValid: true,
              padding: EdgeInsets.fromLTRB(size.width * 0.10,
                  size.height * 0.02, size.width * 0.10, size.height * 0.01),
            ),
            RadiusTextFormField(
              textEditingController: loginViewModel.password,
              hintText: "Password*",
              obsecureText: true,
              icon: const Icon(Icons.password),
              iconInfoisValid: true,
              padding: EdgeInsets.fromLTRB(size.width * 0.10,
                  size.height * 0.02, size.width * 0.10, size.height * 0.01),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.6, bottom: size.width * 0.01),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Forgot password?",
                  style: GoogleFonts.arsenal(
                    textStyle: TextStyle(
                      color: AppColor.buttonColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: CustomButton.button(
                size: size,
                text: "SIGN IN",
                onPressed: () {
                  if (loginViewModel.email.text.isEmpty &&
                      loginViewModel.password.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Please enter every field.");
                  } else {
                    authService
                        .signIn(loginViewModel.email.text,
                            loginViewModel.password.text)
                        .then(
                      (value) {
                        if (value != null) {
                          box.write('user.uid', value.uid);
                          Get.offAll(const DashBoard());
                        }
                      },
                    );
                  }
                },
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(size.width * 0.20,
                    size.height * 0.02, size.width * 0.20, 0),
                child: TextButton(
                  child: Text(
                    "Don't have an account? Register",
                    style: GoogleFonts.arsenal(
                      textStyle: TextStyle(
                        color: AppColor.buttonColor,
                        fontSize: 18,
                      ),
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
    );
  }
}
