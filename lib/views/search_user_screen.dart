


import 'package:apni_mandi_admin/models/user_profile_model.dart';
import 'package:apni_mandi_admin/views/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/district_controller.dart';
import '../../../controllers/mandi_controller.dart';
import '../../../models/district_model.dart';
import '../../../models/mandilist_model.dart';
import '../constants/color_manager.dart';
import '../constants/helper.dart';
import '../constants/text_helper.dart';
import '../constants/values_manager.dart';
import '../controllers/user_profile_controller.dart';
import '../models/business_info_model.dart';

class SearchUserScreen extends StatefulWidget {
  const SearchUserScreen({Key? key}) : super(key: key);

  @override
  State<SearchUserScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {

  final searchController = TextEditingController();
  final UserProfileController _profileController = Get.put(UserProfileController());
  List<UserProfileModel> profileModel = [];
  List<UserProfileModel> searchedModel = [];
  List<UserProfileModel> checkModel = [];
  final UserProfileController _businessProfileController = Get.put(UserProfileController());
  List<BusinessInfoModel> businessModel = [];
  List<BusinessInfoModel> searchBusinessModel = [];
  final DistrictController _districtController = Get.put(DistrictController());
  List<DistrictModel> districtsModel = [];
  final MandiController _mandiController = Get.put(MandiController());
  List<MandiListModel> mandiModel = [];
  String? selectedDistrict;
  String? selectedMandi;
  String? mandiName;
  bool loading = false;
  double height = Get.height;
  double width = Get.width;



  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async{
    profileModel = (await _profileController.getUsersData())!;
    districtsModel = (await _districtController.getAllDistricts())!;
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading == true ?  const Center(child: CircularProgressIndicator()) :
      Column(
        children: [
          buildSpaceVertical(height * 0.1),
          buildSearchField(),
          buildSpaceVertical(height * 0.03),
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
                      borderSide: BorderSide(color: ColorManager.primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                      borderSide: BorderSide(color: ColorManager.primaryColor),
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
                      borderSide: BorderSide(color: ColorManager.primaryColor),
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
                    mandiModel = (await _mandiController.getMandiDataByDistrict(selectedDistrict!))!;
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
          buildSpaceVertical(height * 0.02),
          Obx((){
            if(_mandiController.isLoading.value){
              return const Center(child: CircularProgressIndicator());
            }else {
              return mandiModel.isNotEmpty ?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButtonFormField(
                  isExpanded: true,
                  decoration:  const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                      borderSide: BorderSide(color: ColorManager.primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                      borderSide: BorderSide(color: ColorManager.primaryColor),
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
                      borderSide: BorderSide(color: ColorManager.primaryColor),
                    ),
                    filled: true,
                    fillColor: ColorManager.whiteColor,
                  ),
                  validator: (value) => value == null ?  "Select Mandi": null,
                  dropdownColor: ColorManager.whiteColor,
                  hint: const Text("Select Mandi", style: TextStyle(fontSize: 12)),
                  value: selectedMandi,
                  onChanged: (String? newValue) async {
                    selectedMandi = newValue!;
                    for(int i=0; i<mandiModel.length; i++){
                      if(selectedMandi == mandiModel[i].id){
                        setState(() {
                          mandiName = mandiModel[i].mandiName;
                        });
                      }
                    }

                  },
                  items: mandiModel.map((MandiListModel map) {
                    return DropdownMenuItem(
                      value: map.id,
                      child: Text(map.mandiName ?? "", style: const TextStyle(fontSize: 12)),
                    );
                  }).toList(),
                ),
              )
                  : Center(child: textStyle2(text: 'No Mandi Available'));
            }
          }),
          buildSpaceVertical(height * 0.03),

          InkWell(
            onTap: () async{
              setState(() { loading = true; });

              businessModel = (await _businessProfileController.getSearchedBusinessData())!;
              searchBusinessModel = businessModel.where((business) => business.mandiName!.toLowerCase().contains(mandiName!.toLowerCase())).toList();
              checkModel = profileModel.where((profile) => profile.firstName!.toLowerCase().contains(searchController.text.toLowerCase())).toList();
              for(int i=0; i<checkModel.length; i++){
                for(int j=0; j<searchBusinessModel.length; j++){
                  if(checkModel[i].userId  == searchBusinessModel[j].userId){
                    searchedModel.add(checkModel[i]);
                  }
                }
              }

              setState(() { loading = false; });
            },
            child: Container(
              height: height * 0.05,
              width: width * 0.50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s10),
                  color: ColorManager.primaryColor
              ),
              child: Center(child: textStyle2(text: "Search")),
            ),
          ),

          Expanded(
            child: searchedModel.isNotEmpty ?
            ListView.separated(
                itemCount: searchedModel.length,
                itemBuilder: (context, index) {
                  return buildSearchedCard(searchedModel[index]);
                },
                separatorBuilder: (context, index) {
                  return buildLine();
                })
                : Center(child: textStyle2(text: "No Member Found")),
          ),
        ],
      ),
    );
  }

  Padding buildLine() {
    return const Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
        child: Divider(color: ColorManager.blackColor, thickness: 1, height: AppSize.s28));
  }

  Padding buildSearchedCard(UserProfileModel personalInfoModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: InkWell(
        onTap: () {
          Get.off( ProfileScreen(userProfileModel: personalInfoModel, isApprove: false));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s10),
            color: ColorManager.whiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textStyle2(text: 'Name'),
                      textStyle2(text: personalInfoModel.firstName! +' '+ personalInfoModel.lastName!),
                    ],
                  ),
                ),
                buildSpaceVertical(height * 0.01),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textStyle2(text: "Email:"),
                      textStyle2(text: personalInfoModel.email!),
                    ],
                  ),
                ),
                buildSpaceVertical(height * 0.01),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textStyle2(text: "PhoneNo:"),
                      textStyle2(text: personalInfoModel.phoneNo!),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: TextFormField(
        controller: searchController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter Search Value';
          }
          return null;
        },
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
            borderSide: BorderSide(color: ColorManager.primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
            borderSide: BorderSide(color: ColorManager.primaryColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
            borderSide: BorderSide(color: ColorManager.redColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
            borderSide: BorderSide(color: ColorManager.redColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
            borderSide: BorderSide(color: ColorManager.primaryColor),
          ),
          hintText: "Search by user name",
          hintStyle: TextStyle(fontSize: AppSize.s14),
          fillColor: ColorManager.whiteColor,
          filled: true,
        ),
      ),
    );
  }
}
