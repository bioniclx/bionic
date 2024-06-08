import 'package:bionic/app/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CatalogProductController extends GetxController {
  late TextEditingController updateProductNameController;
  late TextEditingController updateProductStock;
  late TextEditingController updateProductCategory;
  late TextEditingController updateProductPrice;

  //Get the current user id from auth
  final userId = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference ref = FirebaseFirestore.instance.collection('product');

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

  Stream<List<Product>> getProductItem() {
    return FirebaseFirestore.instance
        .collection('product')
        //get all the product where store id is same with currect user id
        .where("store_id", isEqualTo: userId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList());
  }

  Future updateProduct(
    String id,
    String productName,
    String productCategory,
    int productStock,
    int productPrice,
  ) async {
    try {
      final refDoc = ref.doc(id);
      final data = {
        'name': productName,
        'price': productPrice,
        'stock': productStock,
        'category': productCategory,
      };
      refDoc.update(data);
      Get.back();
    } catch (e) {}
  }

  Future<void> deleteProduct(String id) async {
    Get.dialog(AlertDialog(
      title: const Text('Delete'),
      content: const Text('Are you sure'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            ref.doc(id).delete();
            Get.back();
            Get.snackbar('Deleted', "Your data has been removed");
          },
          child: const Text('Yes'),
        ),
      ],
    ));
  }
}
