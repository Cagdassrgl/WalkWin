import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walk_win/pages/login/login_view.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3)).then((value) {
      Get.off(const Login());
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
