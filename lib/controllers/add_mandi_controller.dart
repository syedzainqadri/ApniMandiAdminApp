




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../constants/helper.dart';


class AddMandiController extends GetxController {

  var isLoading = false.obs;
  bool get loadingStatus => isLoading.value;

  addMandi(String mandiName, String cityId, districtId, provinceId) async {
    isLoading.value = true;
    try{
      DocumentReference ref = FirebaseFirestore.instance.collection("mandi").doc();
      await FirebaseFirestore.instance.collection('mandi').doc(ref.id).set({
        "id": ref.id,
        "cityId": cityId,
        "districtId": districtId,
        "provinceId": provinceId,
        "mandiName": mandiName,
      });
      isLoading.value = false;
      successToast("Success", "Mandi Created Successfully");
      Get.offAllNamed('/home');
    }catch(e){
      errorToast("Error", e.toString());
      isLoading.value = false;
    }

  }
}