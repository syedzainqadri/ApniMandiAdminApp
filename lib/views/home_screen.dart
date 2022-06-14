

import 'package:apni_mandi_admin/constants/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/color_manager.dart';
import '../constants/helper.dart';
import '../constants/values_manager.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  double height = Get.height;
  double width = Get.width;
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primaryColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: (){
                box.remove('userId');
                Get.offAllNamed('/login');
              },
              icon: const Icon(Icons.logout, color: ColorManager.whiteColor),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildTopBox(),
            buildSpaceVertical(height * 0.05),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed('/addData');
                    },
                    child: buildCard("Add Mandi", Icons.storefront, ColorManager.whiteColor),
                  ),
                  InkWell(
                      onTap: () {
                        Get.toNamed('/mandi');
                      },
                      child: buildCard("Mandi List", Icons.storefront, ColorManager.whiteColor)
                  ),
                ],
              ),
            ),
            buildSpaceVertical(height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed('/transaction');
                    },
                    child: buildCard("Transactions", Icons.account_balance_sharp, ColorManager.whiteColor),
                  ),
                  InkWell(
                      onTap: () {
                        Get.toNamed('/users');
                      },
                      child: buildCard("All Users", Icons.person_rounded, ColorManager.whiteColor)
                  ),
                ],
              ),
            ),
            buildSpaceVertical(height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed('/pending');
                    },
                    child: Center(child: buildCard("Pending\nUsers", Icons.person_pin_sharp, ColorManager.whiteColor)),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/approved');
                    },
                    child: Center(child: buildCard("Approved\nUsers", Icons.person_pin_sharp, ColorManager.whiteColor)),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
  Container buildTopBox() {
    return Container(
      height: height * 0.2,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s10),
      decoration: const BoxDecoration(
          color: ColorManager.primaryColor,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(AppSize.s40),
            bottomLeft: Radius.circular(AppSize.s40),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(child: textStyle7(text: "Welcome", color: ColorManager.whiteColor)),
          buildSpaceVertical(height * 0.02),
          Center(child: textStyle3(text: "Apni Mandi Admin Panel", color: ColorManager.whiteColor)),
          buildSpaceVertical(height * 0.05),
        ],
      ),
    );
  }

  Container buildCard(String title, IconData icon, Color textColor) {
    return Container(
      height: height * 0.18,
      width: width * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s20),
        color: ColorManager.primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildSpaceVertical(height * 0.01),
          Icon(
            icon,
            color: ColorManager.whiteColor,
            size: AppSize.s40,
          ),
          buildSpaceVertical(height * 0.02),
          textStyle3(text: title, color: textColor, textAlign: TextAlign.center),
          buildSpaceVertical(height * 0.01),
        ],
      ),
    );
  }

}
