


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../constants/helper.dart';


class AddDistrictController extends GetxController {

  var isLoading = false.obs;
  bool get loadingStatus => isLoading.value;

  addDistrict(String districtName, String provinceId) async {
    isLoading.value = true;
    try{
      DocumentReference ref = FirebaseFirestore.instance.collection("districts").doc();
      await FirebaseFirestore.instance.collection('districts').doc(ref.id).set({
        "id": ref.id,
        "provinceId": provinceId,
        "districtName": districtName,
      });
      isLoading.value = false;
      Get.offAllNamed('/home');
    }catch(e){
      errorToast("Error", e.toString());
      isLoading.value = false;
    }

  }
}