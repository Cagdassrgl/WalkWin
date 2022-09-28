import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:walk_win/core/constants/app_consts.dart';
import 'package:walk_win/core/models/activity.dart';
import 'package:walk_win/pages/activityDetail/activity_detail_view.dart';
import 'package:walk_win/pages/history/history_view_model.dart';

Widget historyCell(
    Size size, ActivityModel activity, HistoryMapView historyViewModel) {
  return Column(
    children: [
      Container(
        alignment: Alignment.center,
        height: size.height * 0.2,
        color: Colors.white,
        child: Material(
          child: Container(
            height: size.height * 0.2,
            width: size.width * 0.9,
            decoration: BoxDecoration(
              color: AppColor.secondColor,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  offset: const Offset(-10.0, 10.0),
                  blurRadius: 20.0,
                  spreadRadius: 4.0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.05, top: size.height * 0.02),
                  child: Text(
                    activity.activityName.toString(),
                    style: GoogleFonts.arsenal(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.05, top: size.height * 0.03),
                      child: Text(
                        "${historyViewModel.f.format(activity.activityDistance)} meters",
                        style: GoogleFonts.arsenal(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.05, top: size.height * 0.03),
                      child: Text(
                        "${activity.activityDuration} seconds",
                        style: GoogleFonts.arsenal(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.65,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Get.to(
                        ActivityDetail(
                          polylineCoordinates: activity.geoPointList!,
                        ),
                      );
                    },
                    child: Text(
                      "Details",
                      style: GoogleFonts.arsenal(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 20.0,
      )
    ],
  );
}
