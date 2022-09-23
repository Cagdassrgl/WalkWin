import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
