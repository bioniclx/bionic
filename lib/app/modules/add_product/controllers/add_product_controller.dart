import 'dart:io';

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
    if (name.isNotEmpty &&
        productPriceController.text.isNotEmpty &&
        productCountController.text.isNotEmpty &&
        category.isNotEmpty &&
        image.path.isNotEmpty) {
      final User? user = auth.currentUser;
      final uid = user!.uid;
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
      } catch (e) {
        Get.snackbar('Fail', 'Somthing went wrong');
      }
    } else {
      Get.snackbar('Error', 'missing parameter');
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
