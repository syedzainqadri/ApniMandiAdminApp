

import 'package:apni_mandi_admin/constants/helper.dart';
import 'package:apni_mandi_admin/constants/text_helper.dart';
import 'package:apni_mandi_admin/controllers/add_mandi_controller.dart';
import 'package:apni_mandi_admin/controllers/city_controller.dart';
import 'package:apni_mandi_admin/controllers/district_controller.dart';
import 'package:apni_mandi_admin/controllers/province_controller.dart';
import 'package:apni_mandi_admin/models/city_model.dart';
import 'package:apni_mandi_admin/models/district_model.dart';
import 'package:apni_mandi_admin/models/province_model.dart';
import 'package:apni_mandi_admin/views/widgets/add_city_dialog.dart';
import 'package:apni_mandi_admin/views/widgets/add_district_dialog.dart';
import 'package:apni_mandi_admin/views/widgets/add_province_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/color_manager.dart';
import '../constants/values_manager.dart';
import '../globalWidgets/text_field.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({Key? key}) : super(key: key);

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {

  double height = Get.height;
  double width = Get.width;
  final mandiController = TextEditingController();
  String? selectedProvince;
  String? selectedDistrict;
  String? selectedCity;

  final AddMandiController addMandiController = Get.put(AddMandiController());
  final ProvinceController _provinceController = Get.put(ProvinceController());
  List<ProvinceModel> provinceModel = [];
  final DistrictController _districtController = Get.put(DistrictController());
  List<DistrictModel> districtsModel = [];
  final CityController _cityController = Get.put(CityController());
  List<CityModel> cityModel = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    provinceModel = (await _provinceController.getProvinceData())!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primaryColor,
        elevation: 0,
        title: textStyle2(text: 'Add Mandi', color: ColorManager.whiteColor),
        centerTitle: true,
        iconTheme: const IconThemeData(color: ColorManager.whiteColor),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSpaceVertical(height * 0.04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textStyle2(text: "Provinces"),
                  InkWell(
                    onTap: (){
                      showDialog(
                        barrierColor: Colors.black26,
                        context: context,
                        builder: (context) {
                          return const AddProvinceDialog();
                        },
                      );
                    },
                    child: Container(
                      height: height * 0.04,
                      width: width * 0.35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s16),
                        color: ColorManager.primaryColor,
                      ),
                      child: Center(child: textStyle1(text: 'Add Province', color: ColorManager.whiteColor)),
                    ),
                  ),
                ],
              ),
            ),
            buildSpaceVertical(height * 0.02),
            Obx((){
              if(_provinceController.isLoading.value){
                return const Center(child: CircularProgressIndicator());
              }else {
                return provinceModel.isNotEmpty ?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    decoration:  const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                        borderSide: BorderSide(color: ColorManager.grayColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                        borderSide: BorderSide(color: ColorManager.blackColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                        borderSide: BorderSide(color: ColorManager.redColor),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                        borderSide: BorderSide(color: ColorManager.redColor),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                        borderSide: BorderSide(color: ColorManager.whiteColor),
                      ),
                      filled: true,
                      fillColor: ColorManager.whiteColor,
                    ),
                    validator: (value) => value == null ?  "Select Province": null,
                    dropdownColor: ColorManager.whiteColor,
                    hint: const Text("Select Province", style: TextStyle(fontSize: 12)),
                    value: selectedProvince,
                    onChanged: (String? newValue) async {
                      setState(() {
                        selectedProvince = newValue!;
                      });
                      districtsModel = (await _districtController.getDistrictData(selectedProvince!))!;

                    },
                    items: provinceModel.map((ProvinceModel map) {
                      return DropdownMenuItem(
                        value: map.id,
                        child: Text(map.provinceName ?? "", style: const TextStyle(fontSize: 12)),
                      );
                    }).toList(),
                  ),
                )
                : Center(child: textStyle2(text: 'No Province Available'));
              }
            }),

            buildSpaceVertical(height * 0.04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textStyle2(text: "Districts"),
                  InkWell(
                    onTap: (){
                      if(selectedProvince != null){
                        showDialog(
                          barrierColor: Colors.black26,
                          context: context,
                          builder: (context) {
                            return AddDistrictDialog(provinceId: selectedProvince!);
                          },
                        );
                      }else{
                        errorToast("Error", "Select Province First");
                      }

                    },
                    child: Container(
                      height: height * 0.04,
                      width: width * 0.35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s16),
                        color: ColorManager.primaryColor,
                      ),
                      child: Center(child: textStyle1(text: 'Add District', color: ColorManager.whiteColor)),
                    ),
                  ),
                ],
              ),
            ),
            buildSpaceVertical(height * 0.02),
            Obx((){
              if(_districtController.isLoading.value){
                return const Center(child: CircularProgressIndicator());
              }else {
                return districtsModel.isNotEmpty ?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    decoration:  const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                        borderSide: BorderSide(color: ColorManager.grayColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                        borderSide: BorderSide(color: ColorManager.blackColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                        borderSide: BorderSide(color: ColorManager.redColor),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                        borderSide: BorderSide(color: ColorManager.redColor),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                        borderSide: BorderSide(color: ColorManager.whiteColor),
                      ),
                      filled: true,
                      fillColor: ColorManager.whiteColor,
                    ),
                    validator: (value) => value == null ?  "Select District": null,
                    dropdownColor: ColorManager.whiteColor,
                    hint: const Text("Select District", style: TextStyle(fontSize: 12)),
                    value: selectedDistrict,
                    onChanged: (String? newValue) async {
                      setState(() {
                        selectedDistrict = newValue!;
                      });
                      cityModel = (await _cityController.getCityData(selectedDistrict!))!;

                    },
                    items: districtsModel.map((DistrictModel map) {
                      return DropdownMenuItem(
                        value: map.id,
                        child: Text(map.districtName ?? "", style: const TextStyle(fontSize: 12)),
                      );
                    }).toList(),
                  ),
                )
                    : Center(child: textStyle2(text: 'No District Available'));
              }
            }),

            buildSpaceVertical(height * 0.04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textStyle2(text: "Cities"),
                  InkWell(
                    onTap: (){
                      if(selectedProvince != null){
                        if(selectedDistrict != null){
                          showDialog(
                            barrierColor: Colors.black26,
                            context: context,
                            builder: (context) {
                              return AddCityDialog(provinceId: selectedProvince!, districtId: selectedDistrict!,);
                            },
                          );
                        }else{
                          errorToast("Error", "Select District First");
                        }
                      }else{
                        errorToast("Error", "Select Province First");
                      }
                    },
                    child: Container(
                      height: height * 0.04,
                      width: width * 0.35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s16),
                        color: ColorManager.primaryColor,
                      ),
                      child: Center(child: textStyle1(text: 'Add City', color: ColorManager.whiteColor)),
                    ),
                  ),
                ],
              ),
            ),
            buildSpaceVertical(height * 0.02),
            Obx((){
              if(_cityController.isLoading.value){
                return const Center(child: CircularProgressIndicator());
              }else {
                return cityModel.isNotEmpty ?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    decoration:  const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                        borderSide: BorderSide(color: ColorManager.grayColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                        borderSide: BorderSide(color: ColorManager.blackColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                        borderSide: BorderSide(color: ColorManager.redColor),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                        borderSide: BorderSide(color: ColorManager.redColor),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                        borderSide: BorderSide(color: ColorManager.whiteColor),
                      ),
                      filled: true,
                      fillColor: ColorManager.whiteColor,
                    ),
                    validator: (value) => value == null ?  "Select City": null,
                    dropdownColor: ColorManager.whiteColor,
                    hint: const Text("Select City", style: TextStyle(fontSize: 12)),
                    value: selectedCity,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCity = newValue!;
                      });

                    },
                    items: cityModel.map((CityModel map) {
                      return DropdownMenuItem(
                        value: map.id,
                        child: Text(map.cityName ?? "", style: const TextStyle(fontSize: 12)),
                      );
                    }).toList(),
                  ),
                )
                    : Center(child: textStyle2(text: 'No City Available'));
              }
            }),


            buildSpaceVertical(height * 0.04),
            Padding(
              padding: const EdgeInsets.only(left: AppPadding.p12),
              child: textStyle2(text: "Mandi"),
            ),
            buildSpaceVertical(height * 0.01),
            CustomTextField(
              controller: mandiController,
              hintName: "ENTER MANDI NAME",
            ),
            buildSpaceVertical(height * 0.02),
            Center(
              child: InkWell(
                onTap: (){
                  if(selectedProvince != null){
                    if(selectedDistrict != null){
                      if(selectedCity != null){
                        if(mandiController.text.isNotEmpty){
                          addMandiController.addMandi(mandiController.text.trim(), selectedCity!, selectedDistrict!, selectedProvince!);
                        }else{
                          errorToast("Error", "Select City First");
                        }
                      }else{
                        errorToast("Error", "Select City First");
                      }
                    }else{
                      errorToast("Error", "Select District First");
                    }
                  }else{
                    errorToast("Error", "Select Province First");
                  }
                },
                child: Container(
                    height: height * 0.05,
                    width: width * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s26),
                      color: ColorManager.primaryColor,
                    ),
                    child: Obx((){
                      return addMandiController.isLoading.isTrue ? const Center(child: CircularProgressIndicator())
                          :Center(child: textStyle2(text: 'Save', color: ColorManager.whiteColor));
                    })
                ),
              ),
            ),


            buildSpaceVertical(height * 0.04),
          ],
        ),
      ),
    );
  }
}
