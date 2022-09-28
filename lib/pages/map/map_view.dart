import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walk_win/core/components/map/mapBottom/map_bottom.dart';
import 'package:walk_win/core/components/map/mapTop/map_top.dart';
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
          MapTopView.mapTopView(size, mapViewModel),
          const MapBottom(),
        ],
      ),
    );
  }
}
