import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:walk_win/core/constants/app_consts.dart';
import 'package:walk_win/pages/history/history_view.dart';

class ActivityDetail extends StatelessWidget {
  final List<dynamic> polylineCoordinates;
  const ActivityDetail({super.key, required this.polylineCoordinates});

  @override
  Widget build(BuildContext context) {
    List<LatLng> coordinates = [];
    for (var element in polylineCoordinates) {
      coordinates.add(
        LatLng(element.latitude, element.longitude),
      );
    }

    Set<Polyline> polyline = {
      Polyline(
        color: Colors.red,
        width: 6,
        polylineId: const PolylineId("Route"),
        points: coordinates,
      ),
    };

    Set<Marker> markers = {
      Marker(
          markerId: const MarkerId("Origin"),
          position:
              LatLng(coordinates.first.latitude, coordinates.first.longitude),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: const InfoWindow(title: "Origin")),
      Marker(
          markerId: const MarkerId("Destination"),
          position:
              LatLng(coordinates.last.latitude, coordinates.last.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: const InfoWindow(title: "Destination")),
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Activity Details",
          style: GoogleFonts.arsenal(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColor.firstColor,
        leading: IconButton(
          mouseCursor: MouseCursor.uncontrolled,
          onPressed: () {
            Get.to(const HistoryPage());
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(
              coordinates.first.latitude,
              coordinates.first.longitude,
            ),
            zoom: 16),
        // ignore: invalid_use_of_protected_member
        markers: markers,
        polylines: polyline,
        myLocationEnabled: true,
      ),
    );
  }
}
