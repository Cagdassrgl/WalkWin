import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
    MapViewModel viewModel = Get.put(MapViewModel());

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.7,
            width: double.infinity,
            child: FutureBuilder(
              future: viewModel.getFirstLocation(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Obx(
                    () => GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                            viewModel.latitude.value,
                            viewModel.longitude.value,
                          ),
                          zoom: 16),
                      // ignore: invalid_use_of_protected_member
                      markers: viewModel.markers.value,
                      onMapCreated: (mapController) {
                        viewModel.controller.complete(mapController);
                      },
                      polylines: viewModel.getPolyline(),
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
              height: size.height * 0.3,
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
                              "${viewModel.activityDistance ?? viewModel.distance.value} m",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
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
                            const EdgeInsets.only(left: 16, top: 8, bottom: 8),
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
                        padding:
                            const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                        child: Container(
                          width: size.width * 0.45,
                          height: size.height * 0.06,
                          decoration: BoxDecoration(
                            color: AppColor.thirdColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "${viewModel.timer.secondTime.value} sn",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                  //calori
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                  //   child: Container(
                  //     width: size.width * 0.45,
                  //     height: size.height * 0.06,
                  //     decoration: BoxDecoration(
                  //       color: AppColor.thirdColor,
                  //       borderRadius: BorderRadius.circular(20),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: SpeedDial(
        backgroundColor: AppColor.thirdColor,
        icon: Icons.hiking_rounded,
        activeBackgroundColor: AppColor.fourthColor,
        buttonSize: const Size(64, 64),
        children: [
          SpeedDialChild(
            child: IconButton(
              onPressed: () {
                viewModel.speedStartButton();
              },
              icon: const Icon(Icons.location_on),
            ),
          ),
          SpeedDialChild(
            child: IconButton(
              onPressed: () {
                viewModel.speedStopButton();
              },
              icon: const Icon(Icons.location_off),
            ),
          ),
        ],
      ),
    );
  }
}
