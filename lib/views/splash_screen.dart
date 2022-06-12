


import 'dart:async';
import 'package:apni_mandi_admin/constants/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/helper.dart';
import '../constants/text_helper.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{

  var duration = const Duration(milliseconds: 2000);
  double height = Get.height;
  double width = Get.width;
  String? userId;
  final box = GetStorage();


  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    return Timer(duration, route);
  }

  route() async{
    userId = box.read('userId');
    if(userId != null){
      Get.offNamed('/home');
    }else{
      Get.offNamed('/login');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/logo.png"),
          buildSpaceVertical(height * 0.05),
          Center(child: textStyle6(text: "Anjamn - e Artian Pakistan", color: ColorManager.primaryColor)),
          buildSpaceVertical(height * 0.02),
          Center(child: textStyle2(
              text: 'Anjuman Agree Produce Commission agents (AAPCA)',
              textAlign: TextAlign.center,
              color: ColorManager.primaryColor)),

        ],
      ),
    );
  }
}