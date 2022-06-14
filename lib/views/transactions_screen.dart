

import 'package:apni_mandi_admin/constants/values_manager.dart';
import 'package:apni_mandi_admin/models/payment_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/color_manager.dart';
import '../constants/text_helper.dart';
import '../controllers/payment_controller.dart';
import '../controllers/user_profile_controller.dart';
import '../models/user_profile_model.dart';
import 'profile_screen.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {

  final PaymentController _paymentController = Get.put(PaymentController());
  final UserProfileController _usersController = Get.put(UserProfileController());
  UserProfileModel? usersModel;
  List<PaymentModel> paymentModel = [];
  List<PaymentModel> pendingModel = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    paymentModel = (await _paymentController.getPaymentData())!;
    for(int i=0; i<paymentModel.length; i++){
      if(paymentModel[i].approved == ''){
        pendingModel.add(paymentModel[i]);
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
        title: textStyle2(text: 'All Transactions', color: ColorManager.whiteColor),
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
        return _paymentController.isLoading.isTrue ? const Center(child: CircularProgressIndicator())
            :
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12, vertical: AppPadding.p12),
          child: ListView.separated(
            itemCount: pendingModel.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('assets/logo.png'),
                  backgroundColor: ColorManager.whiteColor,
                  radius: 30,
                ),
                title: textStyle3(text: pendingModel[index].userName!),
                subtitle: textStyle1(text: pendingModel[index].transID!),
                trailing: textStyle1(text: pendingModel[index].phoneNo!),
                onTap: () async{
                  usersModel = await _usersController.getUserDataById(pendingModel[index].userId!);
                  if(usersModel != null){
                    Get.to(ProfileScreen(userProfileModel: usersModel!, isApprove: true, paymentModel: pendingModel[index]));
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
