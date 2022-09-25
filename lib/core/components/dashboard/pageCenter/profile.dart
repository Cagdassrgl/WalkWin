import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:walk_win/core/constants/app_consts.dart';
import 'package:walk_win/pages/login/login_view.dart';
import 'package:walk_win/pages/login/login_view_model.dart';

class SignOut {
  static Widget button(Size size) {
    var controller = Get.put(LoginViewModel());
    return GestureDetector(
      onTap: () {
        controller.signOut();
        GetStorage().remove("user.uid");
        Get.offAll(const Login());
      },
      child: Container(
        width: size.width * 0.25,
        height: size.width * 0.25,
        decoration: BoxDecoration(
          color: AppColor.thirdColor,
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        child: Column(
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.logout,
                color: Colors.white,
                size: 50,
              ),
            ),
            Text(
              "Logout",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
