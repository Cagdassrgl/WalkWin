import 'package:flutter/material.dart';

class UserInfo {
  static Widget user(Size size) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.03),
      child: Stack(
        children: [
          Image.asset(
            "assets/dashboard/center.png",
            width: size.width * 0.9,
            height: size.height * 0.2,
            fit: BoxFit.fill,
          ),
          Positioned(
            top: size.height * 0.04,
            left: size.width * 0.1,
            child: const Text(
              "Total Distance",
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.08,
            left: size.width * 0.1,
            child: const Text(
              "10 km",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
