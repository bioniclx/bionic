import 'package:bionic/app/components/custom_snackbar.dart';
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
      showSuccessSnackbar('Success', 'Login Success');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'channel-error') {
        showWarningSnackbar('Invalid Empty', 'Please fill your data');
      } else if (e.code == "invalid-email") {
        showWarningSnackbar(
            'Invalid Email', 'Please enter a valid email address');
      } else if (e.code == "invalid-credential") {
        showWarningSnackbar('Wrong Input', 'wrong username & password');
      }
    }
  }
}
