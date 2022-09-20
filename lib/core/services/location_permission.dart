import 'package:geolocator/geolocator.dart';

class PermissionService {
  static Future<LocationPermission> requestPermission() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    while (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.denied) {
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
