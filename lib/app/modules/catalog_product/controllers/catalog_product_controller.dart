import 'dart:io';

import 'package:bionic/app/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CatalogProductController extends GetxController {
  late TextEditingController updateProductNameController;
  late TextEditingController updateProductStock;
  late TextEditingController updateProductCategory;
  late TextEditingController updateProductPrice;

  //image picker setup
  var image = XFile('').obs;

  String storeId = Get.arguments;
  //Get the current user id from auth
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final storeId = Get.arguments;
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
        .where("store_id", isEqualTo: storeId)
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
    File images,
  ) async {
    try {
      if (image.value.path.isNotEmpty) {
        String imageUrl = await uploadFile(images);
        final refDoc = ref.doc(id);
        final data = {
          'name': productName,
          'price': productPrice,
          'stock': productStock,
          'category': productCategory,
          'image': imageUrl,
        };
        refDoc.update(data);
      } else {
        final refDoc = ref.doc(id);
        final data = {
          'name': productName,
          'price': productPrice,
          'stock': productStock,
          'category': productCategory,
        };
        refDoc.update(data);
      }

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
}
