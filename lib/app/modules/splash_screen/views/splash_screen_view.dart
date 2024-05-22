import 'package:bionic/app/components/custom_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash.jpg'),
          ),
        ),
        child: Center(
          child: SizedBox(
            height: 350,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: CustomText(
                    text: controller.text,
                    textSize: 20,
                    textColor: Colors.black,
                    textWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
