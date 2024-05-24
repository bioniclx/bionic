import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var isPasswordObscured = true.obs;
  var isConfirmPasswordObscured = true.obs;

  void togglePasswordVisibility() {
    isPasswordObscured.value = !isPasswordObscured.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordObscured.value = !isConfirmPasswordObscured.value;
  }

  void register() async {
    final String name = nameController.text.trim();
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();
    final String confirmPassword = confirmPasswordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      Get.snackbar(
        'Error',
        'Perlu di isi semua',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar(
        'Error',
        'Password tidak sesuai',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Optionally update the user's display name
      await userCredential.user?.updateDisplayName(name);

      Get.snackbar(
        'Berhasil',
        'Pendaftaran Sukses',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case 'email-already-in-use':
          message = 'Email Sudah di gunakan';
          break;
        case 'invalid-email':
          message = 'Email tidak sesuai';
          break;
        case 'weak-password':
          message = 'Password anda lemah';
          break;
        default:
          message = 'An undefined Error happened.';
      }

      Get.snackbar(
        'Error',
        message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
