import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walk_win/core/components/appBar/custom_appbar.dart';
import 'package:walk_win/core/components/history/history_cell.dart';
import 'package:walk_win/core/models/activity.dart';
import 'package:walk_win/pages/dashboard/dashboard_view.dart';
import 'package:walk_win/pages/history/history_view_model.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final historyViewModel = Get.put(HistoryMapView());

    return Scaffold(
      appBar: CustomAppBar(
        text: "Activity History",
        onPressed: () {
          Get.to(const DashBoard());
        },
      ).appBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Container(
          width: double.infinity,
          height: size.height,
          color: Colors.white,
          child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: historyViewModel.getActivity(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    ActivityModel activity = ActivityModel.fromJson(
                        snapshot.data!.docs[index].data());
                    return historyCell(size, activity, historyViewModel);
                  },
                );
              } else {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
