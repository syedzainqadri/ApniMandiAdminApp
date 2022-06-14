

import 'package:apni_mandi_admin/constants/values_manager.dart';
import 'package:apni_mandi_admin/models/users_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/color_manager.dart';
import '../constants/text_helper.dart';
import '../controllers/user_profile_controller.dart';
import '../controllers/users_controller.dart';
import '../models/user_profile_model.dart';
import 'profile_screen.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {

  final UsersController _usersController = Get.put(UsersController());
  List<UsersModel> userModel = [];
  final UserProfileController _userProfileController = Get.put(UserProfileController());
  UserProfileModel? usersProfileModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    userModel = (await _usersController.getUsersData())!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primaryColor,
        elevation: 0,
        title: textStyle2(text: 'All Users', color: ColorManager.whiteColor),
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
                  itemCount: userModel.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: AssetImage('assets/logo.png'),
                        backgroundColor: ColorManager.whiteColor,
                        radius: 30,
                      ),
                      title: textStyle3(text: userModel[index].name!),
                      subtitle: textStyle1(text: userModel[index].email!),
                      onTap: () async{
                        usersProfileModel = await _userProfileController.getUserDataById(userModel[index].userId!);
                        if(usersProfileModel != null){
                          Get.to(ProfileScreen(userProfileModel: usersProfileModel!, isApprove: false));
                        }
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
