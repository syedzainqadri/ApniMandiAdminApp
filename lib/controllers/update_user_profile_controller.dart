


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


class UpdateUserProfileController extends GetxController {

  var isLoading = false.obs;
  bool get loadingStatus => isLoading.value;

  void updateProfileData(String id, String firstName, String lastName, String email, String phoneNo, String cnicNo, String province, String city, String address, String mcln, String image) async {
    isLoading.value = true;
    String userName = firstName+" "+lastName;
    List<String> splitList = userName.split(' ');
    List<String> indexList = [];
    for(int i=0; i< splitList.length; i++){
      for(int j=0; j< splitList[i].length + i; j++){
        indexList.add(splitList[i].substring(0,j).toLowerCase());
      }
    }
    await FirebaseFirestore.instance.collection('usersPersonalData').doc(id).update({
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "userName": userName.toLowerCase(),
      "email": email,
      "phoneNo": phoneNo,
      "cnicNo": cnicNo,
      "province": province,
      "city": city,
      "address": address,
      "mclNo": mcln,
      "approved": "approved",
      "image": image,
      "searchIndex": indexList,
    });
    isLoading.value = false;
    Get.offAllNamed('/home');
  }

}