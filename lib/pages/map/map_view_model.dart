import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:walk_win/core/components/customTextField/custom_text_form_field.dart';
import 'package:walk_win/core/services/location_permission.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' as format;
import 'package:walk_win/pages/history/history_view.dart';

class MapViewModel extends GetxController {
  var latitude = 39.9334.obs;
  var longitude = 32.8507.obs;
  var distance = 0.0.obs;
  double totalDistance = 0.0;

  String? activityDistance;

  LatLng? firstPoint;
  LatLng? secondPoint;

  StopWatchTimer timer = StopWatchTimer();

  bool polylineCoordinatesStatus = true;
  bool polylineStatus = false;
  bool startPointStatus = false;
  bool timerStopStatus = false;
  bool timerStartStatus = false;
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  RxList<LatLng> polylineCoordinates = <LatLng>[].obs;
  List<GeoPoint> geoPointList = [];
  RxSet<Marker> markers = <Marker>{}.obs;

  final Completer<GoogleMapController> controller = Completer();
  TextEditingController activityNameController = TextEditingController();

  late StreamSubscription<LocationData> streamSubscription;

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

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

  @override
  void onClose() {
    streamSubscription.cancel();
    addDistance();
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

    location.changeSettings(
      interval: 2000,
    );

    GoogleMapController googleMapController = await controller.future;

    streamSubscription = location.onLocationChanged.listen(
      (newLoc) {
        latitude.value = newLoc.latitude!;
        longitude.value = newLoc.longitude!;

        //polylinePoint add
        if (polylineStatus & polylineCoordinatesStatus) {
          polylineCoordinates.add(
            LatLng(latitude.value, longitude.value),
          );
          geoPointList.add(GeoPoint(latitude.value, longitude.value));
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

  void activityStartButton() {
    Get.dialog(
      SingleChildScrollView(
        child: AlertDialog(
          title: const Text("Activity Name"),
          content: RadiusTextFormField(
            textEditingController: activityNameController,
            hintText: "Enter activity name",
            icon: const Icon(Icons.directions_walk),
            iconInfoisValid: true,
            padding: const EdgeInsets.all(16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(closeOverlays: true);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (activityNameController.text.isNotEmpty) {
                  Get.back();
                  speedStartButton();
                } else {
                  Fluttertoast.showToast(msg: "Please enter an activity name");
                }
              },
              child: const Text("Start Activity"),
            ),
          ],
        ),
      ),
    );
  }

// SpeedDial child Start Button
  void speedStartButton() {
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
  void speedStopButton() {
    if (timerStartStatus) {
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

      postActivity(activityNameController.text, distance.value,
          timer.secondTime.value, geoPointList);

      Get.offAll(const HistoryPage());
    } else {
      Fluttertoast.showToast(
          msg: "Please press start activity before ending the activity.");
    }
  }

  void addDistance() async {
    var activities = await _firestore
        .collection("Activity")
        .where("userID", isEqualTo: _auth.currentUser!.uid)
        .get();

    var user = await _firestore
        .collection("Users")
        .where("userID", isEqualTo: _auth.currentUser!.uid)
        .get();

    // ignore: avoid_function_literals_in_foreach_calls
    activities.docs.forEach((element) {
      totalDistance += element.data()['activityDistance'];
    });

    for (var element in user.docs) {
      element.reference.update({
        'totalDistance': totalDistance,
      });
    }
  }

  void postActivity(String activityName, double distance, int duration,
      List<GeoPoint> listGeoPoint) async {
    await _firestore.collection("Activity").doc().set({
      'userID': _auth.currentUser!.uid,
      'activityName': activityName,
      'activityDistance': distance,
      'activityDuration': duration,
      'polylineCoordinates': listGeoPoint,
    });
  }
}
