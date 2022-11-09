import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UpdatePaymentController extends GetxController {
  var isLoading = false.obs;
  bool get loadingStatus => isLoading.value;

  void updatePaymentData(
      String id, String phoneNo, String transID, String userName) async {
    isLoading.value = true;
    await FirebaseFirestore.instance.collection('paymentData').doc(id).update({
      "id": id,
      "userName": userName,
      "phoneNo": phoneNo,
      "transID": transID,
      "approved": "approved",
    });
    isLoading.value = false;
  }
}
