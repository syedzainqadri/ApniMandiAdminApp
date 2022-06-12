


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../constants/helper.dart';


class AddCityController extends GetxController {

  var isLoading = false.obs;
  bool get loadingStatus => isLoading.value;

  addCity(String cityName, districtId, provinceId) async {
    isLoading.value = true;
    try{
      DocumentReference ref = FirebaseFirestore.instance.collection("cities").doc();
      await FirebaseFirestore.instance.collection('cities').doc(ref.id).set({
        "id": ref.id,
        "districtId": districtId,
        "provinceId": provinceId,
        "cityName": cityName,
      });
      isLoading.value = false;
      Get.offAllNamed('/home');
    }catch(e){
      errorToast("Error", e.toString());
      isLoading.value = false;
    }

  }
}