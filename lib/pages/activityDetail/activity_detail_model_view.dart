import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ActivityDetailViewModel extends GetxController {
  Set<Marker>? markers;

  Set<Polyline> getyPolyline(List<dynamic> polylineCoordinates) {
    List<LatLng> coordinates = [];
    for (var element in polylineCoordinates) {
      coordinates.add(
        LatLng(element.latitude, element.longitude),
      );
    }

    markers = {
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

    return {
      Polyline(
        color: Colors.red,
        width: 6,
        polylineId: const PolylineId("Route"),
        points: coordinates,
      ),
    };
  }
}
