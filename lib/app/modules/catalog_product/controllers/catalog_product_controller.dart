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
}
