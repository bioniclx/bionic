import 'package:bionic/app/models/sale.dart';
import 'package:get/get.dart';

class DetailSaleController extends GetxController {
  late Sale sale;
  @override
  void onInit() {
    super.onInit();
    sale = Get.arguments as Sale;
  }
}
