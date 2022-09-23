import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:walk_win/core/constants/app_consts.dart';
import 'package:walk_win/pages/map/map_view_model.dart';

class MapBottom extends GetView<MapViewModel> {
  const MapBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final mapViewModel = Get.put(MapViewModel());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(
        () => Container(
          alignment: Alignment.topLeft,
          width: double.infinity,
          height: size.height * 0.2,
          color: AppColor.firstColor,
          child: Column(
            children: [
              //Distance
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, top: 16, bottom: 8),
                    child: Container(
                      width: size.width * 0.45,
                      height: size.height * 0.06,
                      decoration: BoxDecoration(
                        color: AppColor.thirdColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "Distance",
                          style: GoogleFonts.arsenal(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //Distance

                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, top: 16, bottom: 8),
                    child: Container(
                      width: size.width * 0.45,
                      height: size.height * 0.06,
                      decoration: BoxDecoration(
                        color: AppColor.thirdColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "${mapViewModel.activityDistance ?? mapViewModel.distance.value} m",
                          style: GoogleFonts.arsenal(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  //time
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                    child: Container(
                      width: size.width * 0.45,
                      height: size.height * 0.06,
                      decoration: BoxDecoration(
                        color: AppColor.thirdColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "Duration",
                          style: GoogleFonts.arsenal(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //time
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                    child: Container(
                      width: size.width * 0.45,
                      height: size.height * 0.06,
                      decoration: BoxDecoration(
                        color: AppColor.thirdColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "${mapViewModel.timer.secondTime.value} sn",
                          style: GoogleFonts.arsenal(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
