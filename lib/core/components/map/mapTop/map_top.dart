import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:walk_win/pages/map/map_view_model.dart';

class MapTopView {
  static Widget mapTopView(
    Size size,
    MapViewModel mapViewModel,
  ) {
    return SizedBox(
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
    );
  }
}
