import 'dart:developer';

import 'package:bionic/app/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesController extends GetxController {
  late TextEditingController productNameController;
  final userId = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference refProduct =
      FirebaseFirestore.instance.collection('product');
  List<Product> productDropdown = [];
  @override
  void onInit() {
    super.onInit();
    productNameController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Stream<List<Product>> getProduct(String id) {
    return FirebaseFirestore.instance
        .collection('product')
        .where("store_id", isEqualTo: id)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList());
  }
}
