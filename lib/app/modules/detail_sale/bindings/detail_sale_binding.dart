import 'package:get/get.dart';

import '../controllers/detail_sale_controller.dart';

class DetailSaleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailSaleController>(
      () => DetailSaleController(),
    );
  }
}
