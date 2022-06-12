

import 'package:apni_mandi_admin/controllers/add_city_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/color_manager.dart';
import '../../constants/helper.dart';
import '../../constants/text_helper.dart';
import '../../constants/values_manager.dart';
import '../../globalWidgets/text_field.dart';

class AddCityDialog extends StatefulWidget {
  final String provinceId, districtId;
  const AddCityDialog({Key? key, required this.provinceId, required this.districtId}) : super(key: key);

  @override
  State<AddCityDialog> createState() => _AddCityDialogState();
}

class _AddCityDialogState extends State<AddCityDialog> {

  double height = Get.height;
  double width = Get.width;
  final cityController = TextEditingController();
  final AddCityController addCityController = Get.put(AddCityController());

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
            Center(child: textStyle2(text: "Add City")),
            buildSpaceVertical(height * 0.02),
            CustomTextField(
              controller: cityController,
              hintName: "ENTER CITY NAME",
            ),
            buildSpaceVertical(height * 0.02),
            Center(
              child: InkWell(
                onTap: (){
                  addCityController.addCity(cityController.text.trim(), widget.districtId, widget.provinceId);
                },
                child: Container(
                    height: height * 0.05,
                    width: width * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s26),
                      color: ColorManager.primaryColor,
                    ),
                    child: Obx((){
                      return addCityController.isLoading.isTrue ? const Center(child: CircularProgressIndicator())
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
