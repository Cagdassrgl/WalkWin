import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:walk_win/pages/dashboard/dashboard_view_model.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' as format;

class UserInfo {
  static Widget user(Size size) {
    final dashboardViewModel = Get.put(DashboardViewModel());
    final auth = FirebaseAuth.instance;

    var f = format.NumberFormat("#####.##", "en_US");

    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.03),
      child: FutureBuilder(
        future:
            dashboardViewModel.getCurrentUserInformation(auth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
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
                  child: Text(
                    "Total Distance",
                    style: GoogleFonts.arsenal(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.08,
                  left: size.width * 0.1,
                  child: Text(
                    "${f.format(snapshot.data!.docs.first.data()['totalDistance'])} m",
                    style: GoogleFonts.arsenal(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
