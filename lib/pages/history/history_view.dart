import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:walk_win/core/constants/app_consts.dart';
import 'package:walk_win/core/models/activity.dart';
import 'package:walk_win/pages/activityDetail/activity_detail_view.dart';
import 'package:walk_win/pages/dashboard/dashboard_view.dart';
import 'package:walk_win/pages/history/history_view_model.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final historyViewModel = Get.put(HistoryMapView());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Activity History",
          style: GoogleFonts.arsenal(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColor.firstColor,
        leading: IconButton(
          mouseCursor: MouseCursor.uncontrolled,
          onPressed: () {
            Get.to(const DashBoard());
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Container(
          width: double.infinity,
          height: size.height,
          color: Colors.white,
          child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: historyViewModel.getActivity(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    ActivityModel activity = ActivityModel.fromJson(
                        snapshot.data!.docs[index].data());
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
                                        left: size.width * 0.05,
                                        top: size.height * 0.02),
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
                                            left: size.width * 0.05,
                                            top: size.height * 0.03),
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
                                            left: size.width * 0.05,
                                            top: size.height * 0.03),
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
                                            polylineCoordinates:
                                                activity.geoPointList!,
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
                  },
                );
              } else {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
