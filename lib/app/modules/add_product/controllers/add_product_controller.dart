import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {
  late TextEditingController productNameController;
  late TextEditingController productPriceController;
  late TextEditingController productCategoryController;
  late TextEditingController productCountController;

  final FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference ref = FirebaseFirestore.instance.collection('product');

  @override
  void onInit() {
    super.onInit();
    productNameController = TextEditingController();
    productPriceController = TextEditingController();
    productCategoryController = TextEditingController();
    productCountController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> addProduct(
    String name,
    String price,
    String stock,
    String category,
  ) async {
    if (name.isNotEmpty &&
        price.isNotEmpty &&
        stock.isNotEmpty &&
        category.isNotEmpty) {
      final User? user = auth.currentUser;
      final uid = user!.uid;
      try {
        String dateNow = DateTime.now().toString();
        final refDoc = ref.doc();
        final data = {
          'id': refDoc.id,
          'store_id': uid,
          'name': name,
          'price': price,
          'stock': stock,
          'category': category,
          'created_at': dateNow,
        };
        refDoc.set(data);
        Get.back();
      } catch (e) {
        Get.snackbar('Fail', 'Somthing went wrong');
      }
    } else {
      Get.snackbar('Error', 'missing parameter');
    }
  }
}
