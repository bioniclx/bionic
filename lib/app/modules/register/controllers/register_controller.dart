import 'package:bionic/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController testController;
  CollectionReference ref = FirebaseFirestore.instance.collection('user');

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    testController = TextEditingController();
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
    String password,
    String confirmPassword,
  ) async {
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar('Error', 'Data can\'t be empty');
    } else if (password != confirmPassword) {
      Get.snackbar('Error', 'Password didn\'t match');
    } else {
      try {
        String dateNow = DateTime.now().toString();

        var data = {
          'email': email,
          'register_at': dateNow,
        };

        await ref.doc(email).set(data);
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        Get.snackbar('Success', 'User created');
        Get.offAndToNamed(Routes.AUTH);
      } catch (e) {
        Get.snackbar('title', 'message');
      }
    }
  }
}
