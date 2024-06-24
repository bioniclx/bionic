import 'package:bionic/app/components/custom_snackbar.dart';
import 'package:bionic/app/models/product_cart.dart';
import 'package:bionic/app/models/product_dropdown.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesController extends GetxController {
  late TextEditingController productNameController;
  late TextEditingController totalAmountController;
  late TextEditingController nameTextFieldController;
  late TextEditingController adressTextFieldController;
  late TextEditingController phoneTextFieldController;
  late TextEditingController diskonTextFieldController;

  final userId = FirebaseAuth.instance.currentUser!.uid;
  final String storeId = Get.arguments;
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
    nameTextFieldController = TextEditingController();
    adressTextFieldController = TextEditingController();
    phoneTextFieldController = TextEditingController();
    diskonTextFieldController = TextEditingController();

    fetchItems();
    diskonTextFieldController.addListener(() {
      updateDiscountedTotal(total);
    });
  }

  @override
  void onClose() {
    productNameController.dispose();
    totalAmountController.dispose();
    nameTextFieldController.dispose();
    adressTextFieldController.dispose();
    phoneTextFieldController.dispose();
    diskonTextFieldController.dispose();
    super.onClose();
  }

  void fetchItems() async {
    try {
      isLoading(true);
      var snapshot = await FirebaseFirestore.instance
          .collection('product')
          .where("store_id", isEqualTo: storeId)
          .where("stock", isGreaterThan: 0)
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
              if (existingProduct.qty >= productData['stock']) {
                showWarningSnackbar('Kesalahan',
                    'Stok produk ${existingProduct.productName} tidak mencukupi');
                return;
              }
              existingProduct.qty += 1;
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
      showSuccessSnackbar(
          'Success', 'Produk ${selectedItem.value!.name} berhasil ditambahkan');
      fetchItems();
      update();
      updateTotal();
    } else {
      showWarningSnackbar('Kesalahan', 'Silahkan pilih item terlebih dahulu');
      print('No item selected');
    }
  }

  void updateProductQuantity(String id, int newQty) {
    var product = cartProducts.firstWhere((product) => product.id == id);
    if (newQty > 0) {
      if (newQty > product.productStock) {
        showWarningSnackbar(
            'Kesalahan', 'Stok produk ${product.productName} tidak mencukupi');
        return;
      }
      product.qty = newQty;
      cartProducts.refresh();
      updateTotal();
    } else {
      removeProduct(id);
    }
  }

  void removeProduct(String id) {
    cartProducts.removeWhere((product) => product.id == id);
    cartProducts.refresh();
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
    updateDiscountedTotal(totalAmount);
    update();
  }

  void updateDiscountedTotal(totalAmount) {
    int discount = int.parse(diskonTextFieldController.text.isEmpty
        ? "0"
        : diskonTextFieldController.text);
    int discountedTotal = totalAmount - discount;
    totalAmountController.text = discountedTotal.toString();
    update();
  }

  Future<void> storeSale() async {
    if (nameTextFieldController.text.isEmpty) {
      showWarningSnackbar('Kesalahan', 'Nama tidak boleh kosong');
      return;
    }

    if (adressTextFieldController.text.isEmpty) {
      showWarningSnackbar('Kesalahan', 'Alamat tidak boleh kosong');
      return;
    }

    if (phoneTextFieldController.text.isEmpty) {
      showWarningSnackbar('Kesalahan', 'Nomor telepon tidak boleh kosong');
      return;
    }
    if (phoneTextFieldController.text.length < 10) {
      showWarningSnackbar('Kesalahan', 'Nomor telepon tidak valid');
      return;
    }
    //check in phone is value number
    if (int.tryParse(phoneTextFieldController.text) == null) {
      showWarningSnackbar('Kesalahan', 'Nomor telepon tidak valid');
      return;
    }
    if (cartProducts.isEmpty) {
      showWarningSnackbar('Kesalahan', 'Keranjang belanja kosong');
      return;
    }
    var saleData = {
      'name': nameTextFieldController.text,
      'address': adressTextFieldController.text,
      'phone': phoneTextFieldController.text,
      'discount': diskonTextFieldController.text,
      'total': totalAmountController.text,
      'products': cartProducts.map((product) => product.toJson()).toList(),
      'created_at': FieldValue.serverTimestamp(),
      'store_id': storeId,
      'stored_by': userId,
    };
    try {
      await FirebaseFirestore.instance.collection('sales').add(saleData);
      showSuccessSnackbar('Success', 'Penjualan berhasil disimpan');
      cartProducts.forEach((product) {
        updateProductStock(product.id, product.productStock - product.qty);
      });
      clearAllProduct();
      nameTextFieldController.clear();
      adressTextFieldController.clear();
      phoneTextFieldController.clear();
      diskonTextFieldController.clear();
      totalAmountController.clear();
      update();
    } catch (e) {
      showErrorSnackbar('Error', 'Gagal menyimpan penjualan');
      print('Failed to store sale: $e');
    }
  }

  void updateProductStock(String id, int newStock) async {
    try {
      await FirebaseFirestore.instance
          .collection('product')
          .doc(id)
          .update({'stock': newStock});
    } catch (e) {
      print('Failed to update product stock: $e');
    }
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
