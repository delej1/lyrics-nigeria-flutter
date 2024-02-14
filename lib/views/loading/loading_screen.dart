import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyrics_nigeria_flutter/base/custom_loader.dart';
import 'package:lyrics_nigeria_flutter/helpers/route_helper.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      Get.offAndToNamed(RouteHelper.getInitial());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF11998e),
                Color(0xFF38ef7d).withOpacity(0.5),
              ]
          )
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(child: CustomLoader()),
      ),
    );
  }
}
