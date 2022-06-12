

import 'package:apni_mandi_admin/controllers/add_district_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/color_manager.dart';
import '../../constants/helper.dart';
import '../../constants/text_helper.dart';
import '../../constants/values_manager.dart';
import '../../globalWidgets/text_field.dart';

class AddDistrictDialog extends StatefulWidget {
  final String provinceId;
  const AddDistrictDialog({Key? key, required this.provinceId}) : super(key: key);

  @override
  State<AddDistrictDialog> createState() => _AddDistrictDialogState();
}

class _AddDistrictDialogState extends State<AddDistrictDialog> {

  double height = Get.height;
  double width = Get.width;
  final districtController = TextEditingController();
  final AddDistrictController addDistrictController = Get.put(AddDistrictController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: ColorManager.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        height: height * 0.25,
        width: width * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildSpaceVertical(height * 0.02),
            Center(child: textStyle2(text: "Add District")),
            buildSpaceVertical(height * 0.02),
            CustomTextField(
              controller: districtController,
              hintName: "ENTER DISTRICT NAME",
            ),
            buildSpaceVertical(height * 0.02),
            Center(
              child: InkWell(
                onTap: (){
                  addDistrictController.addDistrict(districtController.text.trim(), widget.provinceId);
                },
                child: Container(
                    height: height * 0.05,
                    width: width * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s26),
                      color: ColorManager.primaryColor,
                    ),
                    child: Obx((){
                      return addDistrictController.isLoading.isTrue ? const Center(child: CircularProgressIndicator())
                          :Center(child: textStyle2(text: 'Save', color: ColorManager.whiteColor));
                    })
                ),
              ),
            ),
            buildSpaceVertical(height * 0.02),
          ],
        ),
      ),
    );
  }
}
