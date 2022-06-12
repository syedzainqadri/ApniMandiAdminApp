


import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/helper.dart';

class LoginController extends GetxController {

  var isLoading = false.obs;
  UserCredential? _userCredential;
  User? user;
  FirebaseAuth auth = FirebaseAuth.instance;

  bool get loadingStatus => isLoading.value;


  void login(String email, String password) async {
    final box = GetStorage();
    try {
      isLoading.value = true;
      _userCredential =  await auth.signInWithEmailAndPassword(email: email, password: password);
      box.write("userId", _userCredential!.user!.uid);
      isLoading.value = false;
      Get.toNamed('/home');
      successToast("Success", "Logged In Successfully");
    } on FirebaseAuthException catch (e) {
      errorToast("Error", e.message!);
      isLoading.value = false;
    } catch (e) {
      errorToast("Error", e.toString());
      isLoading.value = false;
    }
  }

  void signOut() {
    try {
      auth.signOut();
    } catch (e) {
      errorToast("Error", e.toString());
    }
  }

}