import 'package:flutter/material.dart';
import 'package:walk_win/core/constants/app_consts.dart';

class Leaderboard {
  static Widget leaderBoard(Size size) {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      height: size.height * 0.6,
      decoration: BoxDecoration(
        color: AppColor.secondColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.05, top: size.height * 0.02),
            child: const Text(
              "Leaderboard",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return const ListTile(
                  leading: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.white,
                  ),
                  trailing: Text(
                    "10 km",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  title: Text(
                    "Çağdaş Sarıgil",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
