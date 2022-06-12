

import 'package:apni_mandi_admin/models/province_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../constants/helper.dart';

class ProvinceController extends GetxController {

  var isLoading = false.obs;
  String? id;
  bool get loadingStatus => isLoading.value;


  Future<List<ProvinceModel>?> getProvinceData() async {
    isLoading.value = true;
    var val = await FirebaseFirestore.instance.collection("provinces").get();
    var documents = val.docs;
    List<ProvinceModel> provinceList = [];
    if (documents.isNotEmpty) {
      try {
        final data = documents.map((doc) => doc.data()).toList();
        for(int i=0; i<data.length; i++){
          provinceList.add(ProvinceModel.fromJson(Map<String, dynamic>.from(data[i])));
        }
        isLoading.value = false;
        return provinceList;
      } catch (e) {
        isLoading.value = false;
        errorToast("Error", e.toString());
        return null;
      }
    }
    isLoading.value = false;
    errorToast("Error", "No Province Available");
    return null;
  }

}