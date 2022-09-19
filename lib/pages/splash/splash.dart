import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:walk_win/core/services/location_permission.dart';
import 'package:walk_win/pages/dashboard/dashboard_view.dart';
import 'package:walk_win/pages/login/login_view.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final box = GetStorage();
  @override
  void initState() {
    super.initState();
    PermissionService.requestPermission();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (box.read("user.uid") != null) {
        Get.off(const DashBoard());
      } else {
        Get.off(const Login());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Image.asset("assets/images/giphy.gif"),
        ),
      ),
    );
  }
}
