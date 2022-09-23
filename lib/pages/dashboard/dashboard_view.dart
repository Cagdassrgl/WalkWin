import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walk_win/core/components/dashboard/pageCenter/history.dart';
import 'package:walk_win/core/components/dashboard/pageCenter/new_activity.dart';
import 'package:walk_win/core/components/dashboard/pageCenter/profile.dart';
import 'package:walk_win/core/components/dashboard/pageBottom/leaderboard.dart';
import 'package:walk_win/core/components/dashboard/pageTop/user_info.dart';
import 'package:walk_win/pages/dashboard/dashboard_view_model.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final dashboardViewModel = Get.put(DashboardViewModel());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: size.height * 0.4,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                UserInfo.user(size),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NewActivity.button(size),
                    const SizedBox(
                      width: 8,
                    ),
                    History.button(size),
                    const SizedBox(
                      width: 8,
                    ),
                    //Profile
                    Profile.button(size),
                  ],
                ),
              ],
            ),
          ),
          Leaderboard.leaderBoard(size),
        ],
      ),
    );
  }
}
