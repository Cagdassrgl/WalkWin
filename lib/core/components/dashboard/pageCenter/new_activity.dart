import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walk_win/core/constants/app_consts.dart';
import 'package:walk_win/pages/map/map_view.dart';

class NewActivity {
  static final activityKey = GlobalKey<FormState>();

  static Widget button(Size size) {
    return //New Activity
        GestureDetector(
      onTap: () {
        Get.to(
          const MapPage(),
        );
      },
      child: Container(
        width: size.width * 0.25,
        height: size.width * 0.25,
        decoration: BoxDecoration(
          color: AppColor.firstColor,
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        child: Column(
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.hiking,
                color: Colors.white,
                size: 50,
              ),
            ),
            Text(
              "New Activity",
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
