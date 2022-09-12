import 'package:flutter/material.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Wrap(
          children: [
            Stack(
              children: [
                Image.asset(
                  "assets/dashboard/top.png",
                ),
                Image.asset(
                  "assets/dashboard/center.png",
                ),
                Image.asset(
                  "assets/dashboard/bottom.png",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
