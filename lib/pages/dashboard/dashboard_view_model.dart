import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DashboardViewModel extends GetxController {
  var totalDistance = 0.0.obs;
  final _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    getUserInformation();
  }

  @override
  void onReady() {}

  @override
  void refresh() {}

  @override
  void onClose() {}

  Future<QuerySnapshot<Map<String, dynamic>>> getUserInformation() async {
    var userDocument = await _firestore.collection("Users").get();

    return userDocument;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCurrentUserInformation(
      String id) async {
    var userDocument = await _firestore
        .collection("Users")
        .where("userID", isEqualTo: id)
        .get();

    return userDocument;
  }
}
