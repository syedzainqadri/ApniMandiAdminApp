


import 'package:apni_mandi_admin/models/mandilist_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../constants/helper.dart';

class MandiController extends GetxController {

  var isLoading = false.obs;
  String? id;
  bool get loadingStatus => isLoading.value;


  Future<List<MandiListModel>?> getMandiData() async {
    isLoading.value = true;
    var val = await FirebaseFirestore.instance.collection("mandi").get();
    var documents = val.docs;
    List<MandiListModel> cityList = [];
    if (documents.isNotEmpty) {
      try {
        final data = documents.map((doc) => doc.data()).toList();
        for(int i=0; i<data.length; i++){
          cityList.add(MandiListModel.fromJson(Map<String, dynamic>.from(data[i])));
        }
        isLoading.value = false;
        return cityList;
      } catch (e) {
        isLoading.value = false;
        errorToast("Error", e.toString());
        return null;
      }
    }
    isLoading.value = false;
    errorToast("Error", "No Mandi Available");
    return null;
  }

}