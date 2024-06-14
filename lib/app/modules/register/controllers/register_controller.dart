import 'package:bionic/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController storeNameController;
  CollectionReference ref = FirebaseFirestore.instance.collection('user');
  var auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    storeNameController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void textLoginclicked() {
    Get.offNamed(Routes.AUTH);
  }

  void registerAccouhnt(
    String email,
    String storeName,
    String password,
    String confirmPassword,
    String role,
  ) async {
    if (email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        storeName.isEmpty) {
      Get.snackbar('Error', 'Data can\'t be empty');
    } else if (password != confirmPassword) {
      Get.snackbar('Error', 'Password didn\'t match');
    } else {
      try {
        String dateNow = DateTime.now().toString();

        final newStore =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        var data = {
          'uid': newStore.user!.uid,
          'email': email,
          'store_name': storeName,
          'register_at': dateNow,
          'role': role,
        };

        await ref.doc(data['uid']).set(data);

        Get.snackbar('Success', 'User created');
        Get.offAndToNamed(Routes.AUTH);
      } catch (e) {
        Get.snackbar('Error', 'Terjadi Kesalahan ${e.toString()}');
      }
    }
  }
}
