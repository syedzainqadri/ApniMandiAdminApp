

import 'package:apni_mandi_admin/constants/values_manager.dart';
import 'package:apni_mandi_admin/models/user_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/color_manager.dart';
import '../constants/text_helper.dart';
import '../controllers/user_profile_controller.dart';
import 'profile_screen.dart';

class ApprovedUsersScreen extends StatefulWidget {
  const ApprovedUsersScreen({Key? key}) : super(key: key);

  @override
  State<ApprovedUsersScreen> createState() => _ApprovedUsersScreenState();
}

class _ApprovedUsersScreenState extends State<ApprovedUsersScreen> {

  final UserProfileController _usersController = Get.put(UserProfileController());
  List<UserProfileModel> usersModel = [];
  List<UserProfileModel> approvedModel = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    usersModel = (await _usersController.getUsersData())!;
    for(int i=0; i<usersModel.length; i++){
      if(usersModel[i].approved == "approved"){
        approvedModel.add(usersModel[i]);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primaryColor,
        elevation: 0,
        title: textStyle2(text: 'Approved Users', color: ColorManager.whiteColor),
        centerTitle: true,
        iconTheme: const IconThemeData(color: ColorManager.whiteColor),
        actions: [
          IconButton(
            onPressed: (){
              Get.toNamed('/searchView');
            },
            icon: const Icon(Icons.search, color: ColorManager.whiteColor),
          ),
        ],
      ),
      body: Obx((){
        return _usersController.isLoading.isTrue ? const Center(child: CircularProgressIndicator())
            :
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12, vertical: AppPadding.p12),
          child: ListView.separated(
            itemCount: approvedModel.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: approvedModel[index].profileImage != null ?
                CircleAvatar(
                  backgroundImage: NetworkImage(approvedModel[index].profileImage!),
                  backgroundColor: ColorManager.whiteColor,
                  radius: 30,
                ):
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/logo.png'),
                  backgroundColor: ColorManager.whiteColor,
                  radius: 30,
                ),
                title: textStyle3(text: approvedModel[index].firstName! +' '+ approvedModel[index].lastName!),
                subtitle: textStyle1(text: approvedModel[index].email!),
                onTap: (){
                  Get.to(ProfileScreen(userProfileModel: approvedModel[index], isApprove: false));
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p26),
                child: Divider(color: ColorManager.blackColor),
              );
            },
          ),
        );
      }),
    );
  }
}
