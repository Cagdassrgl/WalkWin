import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:walk_win/core/constants/app_consts.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' as format;
import 'package:walk_win/pages/dashboard/dashboard_view_model.dart';

class Leaderboard {
  static Widget leaderBoard(Size size) {
    final dashboardViewModel = Get.put(DashboardViewModel());

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
          FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: dashboardViewModel.getUserInformation(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var f = format.NumberFormat("#####.##", "en_US");
                    return ListTile(
                      leading: Text(
                        (index + 1).toString(),
                        style: GoogleFonts.arsenal(
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Text(
                        f.format(
                          snapshot.data!.docs[index].data()["totalDistance"],
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      title: Text(
                        snapshot.data!.docs[index].data()["username"],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
