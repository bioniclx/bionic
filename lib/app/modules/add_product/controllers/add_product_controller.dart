import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {
  late TextEditingController productNameController;
  late TextEditingController productPriceController;
  late TextEditingController productCategoryController;
  late TextEditingController productCountController;

  final count = 0.obs;
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

  void increment() => count.value++;
}
