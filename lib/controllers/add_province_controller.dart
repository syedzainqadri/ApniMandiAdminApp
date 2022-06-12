

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../constants/helper.dart';

class AddProvinceController extends GetxController {

  var isLoading = false.obs;
  bool get loadingStatus => isLoading.value;
  var provinceId = ''.obs;

  addProvince(String provinceName) async {
    isLoading.value = true;
    try{
      DocumentReference ref = FirebaseFirestore.instance.collection("provinces").doc();
      await FirebaseFirestore.instance.collection('provinces').doc(ref.id).set({
        "id": ref.id,
        "provinceName": provinceName,
      });
      provinceId.value = ref.id;
      isLoading.value = false;
      successToast("Success", "Province Added Successfully");
      Get.offAllNamed('/home');
    }catch(e){
      errorToast("Error", e.toString());
      isLoading.value = false;
    }
  }

}