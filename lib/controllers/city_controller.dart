


import 'package:apni_mandi_admin/models/city_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../constants/helper.dart';

class CityController extends GetxController {

  var isLoading = false.obs;
  String? id;
  bool get loadingStatus => isLoading.value;


  Future<List<CityModel>?> getCityData(String districtId) async {
    isLoading.value = true;
    var val = await FirebaseFirestore.instance.collection("cities").where('districtId', isEqualTo: districtId).get();
    var documents = val.docs;
    List<CityModel> cityList = [];
    if (documents.isNotEmpty) {
      try {
        final data = documents.map((doc) => doc.data()).toList();
        for(int i=0; i<data.length; i++){
          cityList.add(CityModel.fromJson(Map<String, dynamic>.from(data[i])));
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
    errorToast("Error", "No City Available");
    return null;
  }

}