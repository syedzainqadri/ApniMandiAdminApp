

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/payment_model.dart';

class PaymentController extends GetxController {

  var isLoading = false.obs;
  UserCredential? userCredential;
  String? id;
  bool get loadingStatus => isLoading.value;


  Future<List<PaymentModel>?> getPaymentData() async {
    isLoading.value = true;
    var val = await FirebaseFirestore.instance.collection("paymentData").get();
    var documents = val.docs;
    List<PaymentModel> paymentList = [];
    if (documents.isNotEmpty) {
      try {
        final data = documents.map((doc) => doc.data()).toList();
        for(int i=0; i<data.length; i++){
          paymentList.add(PaymentModel.fromJson(Map<String, dynamic>.from(data[i])));
        }
        isLoading.value = false;
        return paymentList;
      } catch (e) {
        isLoading.value = false;
        return null;
      }
    }
    isLoading.value = false;
    return null;
  }

}