import 'dart:io';

import 'package:bionic/app/components/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddProductController extends GetxController {
  late TextEditingController productNameController;
  late TextEditingController productPriceController;
  late TextEditingController productCategoryController;
  late TextEditingController productCountController;

  //Image picker setup
  var image = XFile("").obs;

  //Inisialisasi firebase
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

  //Add product method
  Future<void> addProduct(
    String name,
    int price,
    int stock,
    String category,
    File image,
  ) async {
    if (name.isEmpty) {
      showErrorSnackbar('Kesalahan', 'Nama produk tidak boleh kosong');
      return;
    }
    if (productPriceController.text.isEmpty) {
      showErrorSnackbar('Kesalahan', 'Harga tidak boleh kosong');
      return;
    }
    if (price.isNegative) {
      showErrorSnackbar('Kesalahan', 'Harga tidak boleh negatif');
      return;
    }
    if (price == 0) {
      showErrorSnackbar('Kesalahan', 'Harga tidak boleh 0');
      return;
    }
    if (productCountController.text.isEmpty) {
      showErrorSnackbar('Kesalahan', 'Stok produk tidak boleh kosong');
      return;
    }
    if (stock.isNegative) {
      showErrorSnackbar('Kesalahan', 'Stok produk tidak boleh negatif');
      return;
    }
    if (category.isEmpty) {
      showErrorSnackbar('Kesalahan', 'Kategori produk tidak boleh kosong');
      return;
    }
    if (image.path.isEmpty) {
      showErrorSnackbar('Kesalahan', 'Gambar produk tidak boleh kosong');
      return;
    }
    final uid = auth.currentUser!.uid;
    try {
      String imageUrl = await uploadFile(image);
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
        'image': imageUrl,
      };
      refDoc.set(data);
      Get.back();
      showSuccessSnackbar('Berhasil', 'Produk berhasil ditambahkan');
    } catch (e) {
      showErrorSnackbar('Gagal', 'Terjadi kesalahan : $e');
    }
  }

  Future getImage(bool gallery) async {
    //Instanisation variable for image picker
    ImagePicker picker = ImagePicker();
    XFile? pickedFile;

    if (gallery) {
      pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );
    } else {
      pickedFile = await picker.pickImage(
        source: ImageSource.camera,
      );
    }
    if (pickedFile != null) {
      image.value = pickedFile;
    }
  }
}

Future<String> uploadFile(File image) async {
  final storageRef =
      FirebaseStorage.instance.ref().child('Product/${image.path}');
  await storageRef.putFile(image);
  String returnURL = "";
  await storageRef.getDownloadURL().then(
    (fileURL) {
      returnURL = fileURL;
    },
  );
  return returnURL;
}
