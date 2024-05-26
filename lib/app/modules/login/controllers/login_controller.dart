import 'package:bionic/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void textRegisClicked() {
    Get.toNamed(Routes.REGISTER);
  }

  void signUserIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'channel-error') {
        Get.snackbar('Invalid Empty', 'Please fill your data');
      } else if (e.code == "invalid-email") {
        Get.snackbar('Invalid Email', 'Please enter a valid email address');
      } else if (e.code == "invalid-credential") {
        Get.snackbar('Wrong Input', 'wrong username & password');
      }
    }
  }
}
