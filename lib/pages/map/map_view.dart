import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:walk_win/core/constants/app_consts.dart';
import 'package:walk_win/pages/map/map_view_model.dart';

class MapPage extends GetView<MapViewModel> {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MapViewModel mapViewModel = Get.put(MapViewModel());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.7,
            width: double.infinity,
            child: FutureBuilder(
              future: mapViewModel.getFirstLocation(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Obx(
                    () => GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                            mapViewModel.latitude.value,
                            mapViewModel.longitude.value,
                          ),
                          zoom: 16),
                      // ignore: invalid_use_of_protected_member
                      markers: mapViewModel.markers.value,
                      onMapCreated: (mapController) {
                        mapViewModel.controller.complete(mapController);
                      },
                      polylines: mapViewModel.getPolyline(),
                      myLocationEnabled: true,
                    ),
                  );
                } else {
                  return Stack(
                    children: [
                      const GoogleMap(
                        initialCameraPosition: CameraPosition(
                            target: LatLng(
                              39.9334,
                              32.8507,
                            ),
                            zoom: 6),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.black26,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ),
          Obx(
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
                            const EdgeInsets.only(left: 8, top: 16, bottom: 8),
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
                        padding: const EdgeInsets.only(
                            left: 16, top: 16, bottom: 8, right: 8),
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
                        padding:
                            const EdgeInsets.only(left: 8, top: 16, bottom: 8),
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
                        padding: const EdgeInsets.only(
                            left: 16, top: 16, bottom: 8, right: 8),
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
          Container(
            width: double.infinity,
            height: size.height * 0.1,
            color: AppColor.firstColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(AppColor.thirdColor),
                  ),
                  onPressed: () {
                    //mapViewModel.isDialOpen.value = false;
                    mapViewModel.activityStartButton();
                  },
                  child: Text(
                    "Start",
                    style: GoogleFonts.arsenal(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.1,
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(AppColor.thirdColor),
                  ),
                  onPressed: () {
                    mapViewModel.speedStopButton();
                  },
                  child: Text(
                    "Finish",
                    style: GoogleFonts.arsenal(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
