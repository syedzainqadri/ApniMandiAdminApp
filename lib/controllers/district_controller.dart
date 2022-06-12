


import 'package:apni_mandi_admin/models/district_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../constants/helper.dart';

class DistrictController extends GetxController {

  var isLoading = false.obs;
  String? id;
  bool get loadingStatus => isLoading.value;


  Future<List<DistrictModel>?> getDistrictData(String provinceId) async {
    isLoading.value = true;
    var val = await FirebaseFirestore.instance.collection("districts").where('provinceId', isEqualTo: provinceId).get();
    var documents = val.docs;
    List<DistrictModel> districtList = [];
    if (documents.isNotEmpty) {
      try {
        final data = documents.map((doc) => doc.data()).toList();
        for(int i=0; i<data.length; i++){
          districtList.add(DistrictModel.fromJson(Map<String, dynamic>.from(data[i])));
        }
        isLoading.value = false;
        return districtList;
      } catch (e) {
        isLoading.value = false;
        errorToast("Error", e.toString());
        return null;
      }
    }
    isLoading.value = false;
    errorToast("Error", "No District Available");
    return null;
  }

}