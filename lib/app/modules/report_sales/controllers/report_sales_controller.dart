import 'package:bionic/app/models/sale.dart';
import 'package:bionic/app/utils/utility.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:get/get.dart';

class ReportSalesController extends GetxController {
  //add reference collection
  late var ref = FirebaseFirestore.instance
      .collection('sales')
      .where("store_id", isEqualTo: storeId.value);
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
    if (index == 1) {
      return ref
          .where("created_at",
              isGreaterThan: DateTime.now().subtract(const Duration(days: 7)))
          .snapshots();
    } else if (index == 2) {
      return ref
          .where("created_at",
              isGreaterThan: DateTime.now().subtract(const Duration(days: 30)))
          .snapshots();
    } else if (index == 3) {
      return ref
          .where("created_at",
              isGreaterThan: DateTime.now().subtract(const Duration(days: 180)))
          .snapshots();
    } else {
      return ref.snapshots();
    }
  }

  List<Sale> sales(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map(
      (doc) {
        return Sale.fromJson(
          doc.data(),
        );
      },
    ).toList();
  }

  int calculateTotalRevenue(List<Sale> salesData) {
    int totalRevenue = 0;
    for (var sale in salesData) {
      totalRevenue += int.parse(sale.total);
    }
    return totalRevenue;
  }

  int calculateTotalItems(List<Sale> salesData) {
    int totalItems = 0;
    for (var sale in salesData) {
      for (Products product in sale.products) {
        totalItems += product.qty;
      }
    }
    return totalItems;
  }
}
