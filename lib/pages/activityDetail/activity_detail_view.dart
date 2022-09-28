import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:walk_win/core/components/appBar/custom_appbar.dart';
import 'package:walk_win/pages/activityDetail/activity_detail_model_view.dart';
import 'package:walk_win/pages/history/history_view.dart';

class ActivityDetail extends StatelessWidget {
  final List<dynamic> polylineCoordinates;
  const ActivityDetail({super.key, required this.polylineCoordinates});

  @override
  Widget build(BuildContext context) {
    final detailsViewModel = Get.put(ActivityDetailViewModel());

    return Scaffold(
      appBar: CustomAppBar(
        text: "Activity Details",
        onPressed: () {
          Get.to(const HistoryPage());
        },
      ).appBar(),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(
              polylineCoordinates.first.latitude,
              polylineCoordinates.first.longitude,
            ),
            zoom: 16),
        polylines: detailsViewModel.getyPolyline(polylineCoordinates),
        // ignore: invalid_use_of_protected_member
        markers: detailsViewModel.markers!,

        myLocationEnabled: true,
      ),
    );
  }
}
