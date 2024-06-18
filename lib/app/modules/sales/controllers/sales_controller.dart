import 'package:bionic/app/models/product_cart.dart';
import 'package:bionic/app/models/product_dropdown.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesController extends GetxController {
  late TextEditingController productNameController;
  late TextEditingController totalAmountController;

  final userId = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference refProduct =
      FirebaseFirestore.instance.collection('product');
  List<ProductDropdown> productDropdown = [];
  var isLoading = true.obs;
  var selectedItem = Rx<ProductDropdown?>(null);
  var cartProducts = <ProductCart>[].obs;

  @override
  void onInit() {
    super.onInit();
    productNameController = TextEditingController();
    totalAmountController = TextEditingController();
    fetchItems();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void fetchItems() async {
    try {
      isLoading(true);
      var snapshot = await FirebaseFirestore.instance
          .collection('product')
          .where("store_id", isEqualTo: userId)
          .get();
      var data = snapshot.docs.map((doc) {
        return ProductDropdown(
          id: doc.id,
          name: doc['name'],
        );
      }).toList();
      productDropdown.assignAll(data);
    } finally {
      isLoading(false);
    }
  }

  void setSelectedItem(ProductDropdown? item) {
    selectedItem.value = item;
    print(selectedItem.value!.name);
  }

  void addProduct() async {
    if (selectedItem.value != null) {
      try {
        print("Produk id e: ${selectedItem.value!.id}");
        var doc = await FirebaseFirestore.instance
            .collection('product')
            .doc(selectedItem.value!.id)
            .get();

        if (doc.exists) {
          var productData = doc.data();
          if (productData != null) {
            var existingProduct = cartProducts
                .firstWhereOrNull((product) => product.id == doc.id);
            if (existingProduct != null) {
              updateProductQuantity(doc.id, existingProduct.qty + 1);
              update();
            } else {
              var newProduct = ProductCart(
                id: doc.id,
                productName: productData['name'],
                productPrice: productData['price'],
                productStock: productData['stock'],
                productCategory: productData['category'],
                productImage: productData['image'],
                qty: 1,
              );
              cartProducts.add(newProduct);
            }
            update(); // Ensure the controller is updated
          } else {
            print('Product data is null');
          }
        } else {
          print('Product not found');
        }
      } catch (e) {
        print('Failed to add product: $e');
      }

      Get.snackbar(
          'Success', 'Produk ${selectedItem.value!.name} berhasil ditambahkan');
      fetchItems();
      update();
    } else {
      Get.snackbar('Error', 'Silahkan pilih item terlebih dahulu');
      print('No item selected');
    }
  }

  void updateProductQuantity(String id, int newQty) {
    var product = cartProducts.firstWhere((product) => product.id == id);
    if (newQty > 0) {
      product.qty = newQty;
      cartProducts.refresh();
    } else {
      removeProduct(id);
    }
  }

  void removeProduct(String id) {
    cartProducts.removeWhere((product) => product.id == id);
    cartProducts.refresh();
    // updateTotal();
  }

  void clearAllProduct() {
    cartProducts.clear();
  }

  void updateTotal() {
    int totalAmount = 0;
    cartProducts.forEach((product) {
      totalAmount += product.productPrice * product.qty;
    });
    totalAmountController.text = totalAmount.toString();
  }

  int getProductQuantity(String id) {
    var product = cartProducts.firstWhere((product) => product.id == id);
    return product.qty;
  }

  int get total {
    return cartProducts.fold(
        0, (sum, item) => sum + (item.productPrice * item.qty));
  }
}
