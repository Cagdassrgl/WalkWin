import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' as format;
import 'package:get/get.dart';

class HistoryMapView extends GetxController {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  var f = format.NumberFormat("#####.##", "en_US");

  Future<QuerySnapshot<Map<String, dynamic>>> getActivity() async {
    var activities = await _firestore
        .collection("Activity")
        .where('userID', isEqualTo: _auth.currentUser!.uid)
        .get();

    return activities;
  }
}
