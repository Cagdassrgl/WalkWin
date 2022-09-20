import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:walk_win/core/services/location_permission.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' as format;

class MapViewModel extends GetxController {
  var latitude = 39.9334.obs;
  var longitude = 32.8507.obs;
  var distance = 0.0.obs;
  var seconds = 0.obs;

  String? activityDistance;

  LatLng? firstPoint;
  LatLng? secondPoint;

  StopWatchTimer timer = StopWatchTimer();

  bool polylineCoordinatesStatus = true;
  bool polylineStatus = false;
  bool startPointStatus = false;
  bool timerStopStatus = false;
  bool timerStartStatus = false;

  RxList<LatLng> polylineCoordinates = <LatLng>[].obs;
  RxSet<Marker> markers = <Marker>{}.obs;

  final Completer<GoogleMapController> controller = Completer();

  late StreamSubscription<Position> streamSubscription;

  @override
  void onInit() async {
    super.onInit();
    getCurrentLocation();
  }

  @override
  void dispose() async {
    super.dispose();
    timer.dispose();
  }

  // Users get first location
  Future<Position?> getFirstLocation() async {
    Position position;
    LocationPermission permission = await PermissionService.checkPermission();

    if (permission != LocationPermission.denied ||
        permission != LocationPermission.deniedForever) {
      position = await Geolocator.getCurrentPosition();

      firstPoint = LatLng(position.latitude, position.longitude);

      return position;
    } else {
      permission = await PermissionService.requestPermission();
      if (permission != LocationPermission.denied ||
          permission != LocationPermission.deniedForever) {
        position = await Geolocator.getCurrentPosition();

        firstPoint = LatLng(position.latitude, position.longitude);

        return position;
      }
    }
    return null;
  }

  // Location tracking
  void getCurrentLocation() async {
    Location location = Location();

    GoogleMapController googleMapController = await controller.future;

    location.onLocationChanged.listen(
      (newLoc) {
        latitude.value = newLoc.latitude!;
        longitude.value = newLoc.longitude!;

        //polylinePoint add
        if (polylineStatus & polylineCoordinatesStatus) {
          polylineCoordinates.add(
            LatLng(latitude.value, longitude.value),
          );
        }

        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 16,
              target: LatLng(
                latitude.value,
                longitude.value,
              ),
            ),
          ),
        );

        //distance calculate
        if (timerStartStatus) {
          secondPoint = LatLng(latitude.value, longitude.value);

          distance.value = distance.value +
              Geolocator.distanceBetween(
                firstPoint!.latitude,
                firstPoint!.longitude,
                secondPoint!.latitude,
                secondPoint!.longitude,
              );

          var f = format.NumberFormat("#####.##", "en_US");

          activityDistance = f.format(distance.value);

          firstPoint = secondPoint;
        }
      },
    );
  }

  Set<Polyline> getPolyline() {
    if (polylineStatus) {
      Set<Polyline> polyline = {
        Polyline(
          color: Colors.red,
          width: 6,
          polylineId: const PolylineId("Route"),
          points: polylineCoordinates,
        ),
      };
      return polyline;
    } else {
      Set<Polyline> emptyPolyline = {};
      return emptyPolyline;
    }
  }

// SpeedDial child Start Button
  void speedStartButton() async {
    timerStartStatus = true;
    polylineStatus = true;
    startPointStatus = true;
    timerStopStatus = false;

    markers.add(
      Marker(
        markerId: const MarkerId("origin"),
        position: LatLng(latitude.value, longitude.value),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: const InfoWindow(title: "Origin"),
      ),
    );

    //calculate time
    if (timerStartStatus) {
      timer.onStartTimer();
    } else if (timerStopStatus) {
      timer.onStopTimer();
    }
  }

// SpeedDial child Stop Button
  void speedStopButton() async {
    timerStartStatus = false;
    polylineCoordinatesStatus = false;
    timerStopStatus = true;

    markers.add(
      Marker(
        markerId: const MarkerId("destination"),
        position: LatLng(latitude.value, longitude.value),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: const InfoWindow(title: "Destination"),
      ),
    );
  }
}
