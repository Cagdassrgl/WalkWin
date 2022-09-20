import 'package:flutter/material.dart';
import 'package:walk_win/core/constants/app_consts.dart';

class CustomButton {
  static Widget button(
      {required Size size,
      required String text,
      required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        fixedSize: MaterialStatePropertyAll(
          Size(size.width * 0.7, size.height * 0.06),
        ),
        backgroundColor: MaterialStatePropertyAll(
          AppColor.buttonColor,
        ),
        alignment: Alignment.center,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
