import 'package:bionic/app/models/sale.dart';
import 'package:bionic/app/utils/utility.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:get/get.dart';

class ReportSalesController extends GetxController {
  //add reference collection
  CollectionReference ref = FirebaseFirestore.instance.collection('sales');
  //create list for category
  RxString storeId = Get.arguments;
  final sortedBy = [
    "Semua",
    "1 Minggu",
    "1 Bulan",
    "6 Bulan",
  ];

  //make a variable to change to store every time index clicked
  var selectedCategory = 0.obs;

  //change background and text color every time selectedCategory changed
  isActivated(int index, bool isText) {
    //check function called for text or not
    if (isText) {
      return activatedCategoryText(selectedCategory.value, index);
    } else {
      return activatedCategoryBackground(selectedCategory.value, index);
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getSales(int index) {
    if (index == 0) {
      return FirebaseFirestore.instance
          .collection('sales')
          .where("store_id", isEqualTo: storeId.value)
          .snapshots();
    } else if (index == 1) {
      return FirebaseFirestore.instance
          .collection('sales')
          .where("name", isEqualTo: "test")
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection('sales')
          .where("name", isEqualTo: "Liz")
          .snapshots();
    }
  }

  List<Sale> sales(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map(
      (doc) {
        return Sale.fromJson(doc.data());
      },
    ).toList();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
