

import 'package:apni_mandi_admin/constants/values_manager.dart';
import 'package:apni_mandi_admin/controllers/mandi_controller.dart';
import 'package:apni_mandi_admin/models/mandilist_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/color_manager.dart';
import '../constants/text_helper.dart';

class MandiListScreen extends StatefulWidget {
  const MandiListScreen({Key? key}) : super(key: key);

  @override
  State<MandiListScreen> createState() => _MandiListScreenState();
}

class _MandiListScreenState extends State<MandiListScreen> {

  final MandiController _mandiController = Get.put(MandiController());
  List<MandiListModel> mandiModel = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    mandiModel = (await _mandiController.getMandiData())!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primaryColor,
        elevation: 0,
        title: textStyle2(text: 'All Mandees', color: ColorManager.whiteColor),
        centerTitle: true,
        iconTheme: const IconThemeData(color: ColorManager.whiteColor),
      ),
      body: Obx((){
        return _mandiController.isLoading.isTrue ? const Center(child: CircularProgressIndicator())
            :
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12, vertical: AppPadding.p12),
          child: ListView.separated(
            itemCount: mandiModel.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('assets/logo.png'),
                  backgroundColor: ColorManager.whiteColor,
                  radius: 30,
                ),
                title: textStyle3(text: mandiModel[index].mandiName!),
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
