import 'package:bionic/app/utils/utility.dart';
import 'package:get/get.dart';

class ReportSalesController extends GetxController {
  //create list for category
  final sortedBy = [
    "Semua",
    "1 Minggu",
    "1 Bulan",
    "6 Bulan",
  ];

  //change background and text color every time selectedCategory changed
  isActivated(int index, bool isText) {
    //check function called for text or not
    if (isText) {
      return activatedCategoryText(selectedCategory.value, index);
    } else {
      return activatedCategoryBackground(selectedCategory.value, index);
    }
  }

  //make a variable to change to store every time index clicked
  var selectedCategory = 0.obs;

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
