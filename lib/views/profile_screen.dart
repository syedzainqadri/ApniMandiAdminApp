

import 'package:apni_mandi_admin/controllers/update_payment_controller.dart';
import 'package:apni_mandi_admin/controllers/update_user_profile_controller.dart';
import 'package:apni_mandi_admin/models/payment_model.dart';
import 'package:apni_mandi_admin/models/user_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/color_manager.dart';
import '../constants/helper.dart';
import '../constants/text_helper.dart';
import '../constants/values_manager.dart';

class ProfileScreen extends StatefulWidget {
  final UserProfileModel userProfileModel;
  final PaymentModel? paymentModel;
  final bool isApprove;
  const ProfileScreen({Key? key, required this.userProfileModel, required this.isApprove, this.paymentModel}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  double height = Get.height;
  double width = Get.width;
  final UpdateUserProfileController userProfileController = Get.put(UpdateUserProfileController());
  final UpdatePaymentController updatePaymentController = Get.put(UpdatePaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text("Profile Screen"),
        centerTitle: true,
        backgroundColor: ColorManager.primaryColor,
        elevation: 0,
      ),
      body:  widget.userProfileModel != null ?
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSpaceVertical(height * 0.03),
            widget.userProfileModel.profileImage != null ?
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: ColorManager.grayColor,
                backgroundImage: NetworkImage(widget.userProfileModel.profileImage ?? ''),
              ),
            )
                :
            const Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: ColorManager.grayColor,
                backgroundImage: AssetImage("assets/logo.png"),
              ),
            ),
            buildSpaceVertical(height * 0.03),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textStyle3(text: "Personal Name:"),
                  textStyle2(text: "${widget.userProfileModel.firstName}  ${widget.userProfileModel.lastName} "),
                ],
              ),
            ),

            buildSpaceVertical(height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textStyle3(text: "Personal No:"),
                  textStyle2(text: "${widget.userProfileModel.phoneNo}"),
                ],
              ),
            ),

            buildSpaceVertical(height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textStyle3(text: "Personal Email"),
                  textStyle2(text: "${widget.userProfileModel.email}"),
                ],
              ),
            ),

            buildSpaceVertical(height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textStyle3(text: "Personal CNIC"),
                  textStyle2(text: "${widget.userProfileModel.cnicNo}"),
                ],
              ),
            ),

            buildSpaceVertical(height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textStyle3(text: "City:"),
                  textStyle2(text: "${widget.userProfileModel.city}"),
                ],
              ),
            ),

            buildSpaceVertical(height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textStyle3(text: "Address:"),
                  Expanded(child: textStyle2(text: "${widget.userProfileModel.address}", textAlign: TextAlign.right)),
                ],
              ),
            ),

            buildSpaceVertical(height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textStyle3(text: "Province:"),
                  textStyle2(text: "${widget.userProfileModel.province}"),
                ],
              ),
            ),

            buildSpaceVertical(height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textStyle3(text: "Market Committee\nLicence No:"),
                  textStyle2(text: "${widget.userProfileModel.mcln}"),
                ],
              ),
            ),

            buildSpaceVertical(height * 0.04),
           widget.isApprove == true ?
           InkWell(
              onTap: () async{

                updatePaymentController.updatePaymentData(widget.paymentModel!.userId!, widget.paymentModel!.phoneNo!,
                    widget.paymentModel!.transID!, widget.paymentModel!.userName!);

                userProfileController.updateProfileData(widget.userProfileModel.userId!, widget.userProfileModel.firstName!,
                    widget.userProfileModel.lastName!, widget.userProfileModel.email!, widget.userProfileModel.phoneNo!,
                    widget.userProfileModel.cnicNo!, widget.userProfileModel.province!, widget.userProfileModel.city!,
                    widget.userProfileModel.address!, widget.userProfileModel.mcln!, widget.userProfileModel.profileImage!);

              },
              child: Center(
                child: Container(
                  height: height * 0.06,
                  width: width * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s16),
                    color: ColorManager.primaryColor,
                  ),
                  child: Obx(() {
                    return userProfileController.isLoading.isTrue ? const Center(child: CircularProgressIndicator()):
                    Center(child: textStyle1(text: 'Approve User', color: ColorManager.whiteColor));
                  }),
                ),
              ),
            ): const SizedBox.shrink(),
            buildSpaceVertical(height * 0.03),
          ],
        ),
      )
          : Center(child: textStyle3(text: "No Personal Info Available")),
    );
  }
}
