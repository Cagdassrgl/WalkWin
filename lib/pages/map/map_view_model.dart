import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:walk_win/core/services/location_permission.dart';

class MapViewModel extends GetxController {
  var latitude = 39.9334.obs;
  var longitude = 32.8507.obs;
  var distance = 0.0.obs;
  int timerCounter = 0;

  LatLng? startPoint;
  Timer? timer;
  Rx<Duration> duration = const Duration().obs;

  bool polylineCoordinatesStatus = true;
  bool polylineStatus = false;
  bool startPointStatus = false;
  bool timerStatus = false;
  bool timerStopStatus = false;

  RxList<LatLng> polylineCoordinates = <LatLng>[].obs;
  RxSet<Marker> markers = <Marker>{}.obs;

  final Completer<GoogleMapController> controller = Completer();

  late StreamSubscription<Position> streamSubscription;

  @override
  void onInit() async {
    super.onInit();
    getCurrentLocation();

    // if (timerStatus) {
    //   timer = Timer.periodic(
    //     const Duration(seconds: 1),
    //     (timer) {
    //       const addSeconds = 1;
    //       final seconds = duration.value.inSeconds + addSeconds;
    //       duration.value = Duration(seconds: seconds);

    //       if (timerStopStatus) {
    //         timer.cancel();
    //       }
    //     },
    //   );
    // }
  }

  // Users get first location
  Future<Position?> getFirstLocation() async {
    Position position;
    LocationPermission permission = await PermissionService.checkPermission();

    if (permission != LocationPermission.denied ||
        permission != LocationPermission.deniedForever) {
      position = await Geolocator.getCurrentPosition();

      return position;
    } else {
      permission = await PermissionService.requestPermission();
      if (permission != LocationPermission.denied ||
          permission != LocationPermission.deniedForever) {
        position = await Geolocator.getCurrentPosition();
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

        // User current location marker
        markers.add(
          Marker(
            markerId: const MarkerId("current"),
            position: LatLng(latitude.value, longitude.value),
            infoWindow: const InfoWindow(title: "Current"),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure),
          ),
        );

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
      },
    );
  }

  void addTime(Timer t) {
    const addSeconds = 1;

    final seconds = duration.value.inSeconds + addSeconds;
    duration.value = Duration(seconds: seconds);
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
  void speedStartButton() {
    polylineStatus = true;
    startPointStatus = true;
    timerStatus = true;
    timerStopStatus = false;

    markers.add(
      Marker(
        markerId: const MarkerId("origin"),
        position: LatLng(latitude.value, longitude.value),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: const InfoWindow(title: "Origin"),
      ),
    );
  }

// SpeedDial child Stop Button
  void speedStopButton() {
    polylineCoordinatesStatus = false;
    timerStatus = false;
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
