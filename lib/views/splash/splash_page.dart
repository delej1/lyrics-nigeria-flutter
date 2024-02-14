import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyrics_nigeria_flutter/helpers/route_helper.dart';
import 'package:lyrics_nigeria_flutter/utils/dimensions.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;


  @override
  void initState(){
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    );

    Timer(const Duration(seconds: 2),
            () => Get.offNamed(RouteHelper.getInitial()));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
                scale: animation,
                child: Center(
                    child: Image.asset(
                      "assets/image/lyricsnigeria_ic.png",
                      width:Dimensions.width30*10,
                    ))),
            Center(
                child: Image.asset(
                  "assets/image/lyricsnigeria_ic2.png",
                  width: Dimensions.width30*10,
                )),
          ],
        ),
      ),
    );
  }
}
