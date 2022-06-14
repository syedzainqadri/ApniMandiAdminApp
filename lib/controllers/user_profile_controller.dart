


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/business_info_model.dart';
import '../models/user_profile_model.dart';

class UserProfileController extends GetxController {

  var isLoading = false.obs;
  String? id;
  bool get loadingStatus => isLoading.value;


  Future<List<UserProfileModel>?> getUsersData() async {
    isLoading.value = true;
    var val = await FirebaseFirestore.instance.collection("usersPersonalData").get();
    var documents = val.docs;
    List<UserProfileModel> profileList = [];
    if (documents.isNotEmpty) {
      try {
        final data = documents.map((doc) => doc.data()).toList();
        for(int i=0; i<data.length; i++){
          profileList.add(UserProfileModel.fromJson(Map<String, dynamic>.from(data[i])));
        }
        isLoading.value = false;
        return profileList;
      } catch (e) {
        isLoading.value = false;
        return null;
      }
    }
    isLoading.value = false;
    return null;
  }

  Future<UserProfileModel?> getUserDataById(String id) async {
    isLoading.value = true;
    var val = await FirebaseFirestore.instance.collection("usersPersonalData").doc(id).get();
    var documents = val.data();
    if (documents != null) {
      try {
        UserProfileModel personalData = UserProfileModel.fromJson(Map<String, dynamic>.from(documents));
        isLoading.value = false;
        return personalData;
      } catch (e) {
        isLoading.value = false;
        return null;
      }
    }else{
      isLoading.value = false;
      return null;
    }

  }

  Future<List<BusinessInfoModel>?> getSearchedBusinessData() async {
    isLoading.value = true;
    var val = await FirebaseFirestore.instance.collection("usersBusinessData").get();
    var documents = val.docs;
    List<BusinessInfoModel> profileList = [];
    if (documents.isNotEmpty) {
      try {
        final data = documents.map((doc) => doc.data()).toList();
        for(int i=0; i<data.length; i++){
          profileList.add(BusinessInfoModel.fromJson(Map<String, dynamic>.from(data[i])));
        }
        isLoading.value = false;
        return profileList;
      } catch (e) {
        isLoading.value = false;
        return null;
      }
    }
    isLoading.value = false;
    return null;

  }

}