import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class KaryawanController extends GetxController {
  var karyawanList = <Map<String, dynamic>>[].obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchKaryawanList();
  }

  void fetchKaryawanList() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('karyawan').get();
      var list = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      karyawanList.assignAll(list);
    } catch (e) {
      print('Error fetching karyawan list: $e');
    }
  }

  void registerAccount({
    required String email,
    required String fullName,
    required String position,
    required String password,
    required String confirmPassword,
  }) async {
    if (password != confirmPassword) {
      Get.snackbar('Error', 'Password and Confirm Password do not match');
      return;
    }
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      String uid = userCredential.user!.uid;

      await _firestore.collection('karyawan').doc(uid).set({
        'email': email,
        'fullName': fullName,
        'position': position,
        'role': 2,
      });

      fetchKaryawanList();
      Get.snackbar('Success', 'Karyawan berhasil ditambahkan');
    } catch (e) {
      Get.snackbar('Error', 'Failed to register account: $e');
    }
  }

  void deleteKaryawan(String uid) async {
    try {
      await _firestore.collection('karyawan').doc(uid).delete();
      fetchKaryawanList();
      Get.snackbar('Success', 'Karyawan berhasil dihapus');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete karyawan: $e');
    }
  }

  void updateKaryawan(String uid, String fullName, String position) async {
    try {
      await _firestore.collection('karyawan').doc(uid).update({
        'fullName': fullName,
        'position': position,
      });
      fetchKaryawanList();
      Get.snackbar('Success', 'Karyawan berhasil diperbarui');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update karyawan: $e');
    }
  }
}
