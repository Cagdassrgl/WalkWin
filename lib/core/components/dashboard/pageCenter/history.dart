import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walk_win/core/constants/app_consts.dart';
import 'package:walk_win/pages/history/history_view.dart';

class History {
  static Widget button(Size size) {
    return //History
        GestureDetector(
      onTap: () {
        Get.to(const HistoryPage());
      },
      child: Container(
        width: size.width * 0.25,
        height: size.width * 0.25,
        decoration: BoxDecoration(
          color: AppColor.secondColor,
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        child: Column(
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.history,
                color: Colors.white,
                size: 50,
              ),
            ),
            Text(
              "History",
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
