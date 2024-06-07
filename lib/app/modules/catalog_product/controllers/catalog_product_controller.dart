import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CatalogProductController extends GetxController {
  late TextEditingController updateProductNameController;
  late TextEditingController updateProductStock;
  late TextEditingController updateProductCategory;
  late TextEditingController updateProductPrice;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    updateProductNameController = TextEditingController();
    updateProductStock = TextEditingController();
    updateProductCategory = TextEditingController();
    updateProductPrice = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
