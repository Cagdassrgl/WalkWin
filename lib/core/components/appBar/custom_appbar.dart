import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:walk_win/core/constants/app_consts.dart';

class CustomAppBar {
  String text;
  VoidCallback onPressed;
  CustomAppBar({
    required this.text,
    required this.onPressed,
  });

  PreferredSizeWidget? appBar() {
    return AppBar(
      title: Text(
        text,
        style: GoogleFonts.arsenal(
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: AppColor.firstColor,
      leading: IconButton(
        mouseCursor: MouseCursor.uncontrolled,
        onPressed: onPressed,
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }
}
