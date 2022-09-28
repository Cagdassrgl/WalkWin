import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:restart_app/restart_app.dart';

class PermissionService {
  static Future<LocationPermission> requestPermission() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    while (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        var openSettings = await Geolocator.openAppSettings();
        if (openSettings && permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          Fluttertoast.showToast(msg: "Please give location permission");
          Future.delayed(const Duration(seconds: 10)).then((value) async {
            permission = await Geolocator.checkPermission();
            if (permission == LocationPermission.denied ||
                permission == LocationPermission.deniedForever) {
              Restart.restartApp();
            }
          });
        }
        break;
      }
    }
    return permission;
  }

  static Future<LocationPermission> checkPermission() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    return permission;
  }
}
