import 'package:bionic/app/components/custom_button_icon.dart';
import 'package:bionic/app/models/sale.dart';
import 'package:bionic/app/routes/app_pages.dart';
import 'package:bionic/app/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailSaleController extends GetxController {
  late Sale sale;
  late RxString role;
  @override
  void onInit() {
    super.onInit();
    sale = Get.arguments['sale'] as Sale;
    role = Get.arguments['role'];
  }

  Widget buttonAddProductClicked() {
    checkUserRole(role.value);
    if (isOwner) {
      return CustomButtonWithIcon(
        buttonText: 'Tambah Produk',
        buttonIcon: Icons.add,
        buttonHeight: 110,
        buttonWidth: 110,
        onTap: () {
          Get.toNamed(Routes.ADD_PRODUCT);
        },
      );
    } else {
      return CustomButtonWithIcon(
        buttonText: 'Lihat Produk',
        buttonIcon: Icons.add_shopping_cart_rounded,
        buttonHeight: 110,
        buttonWidth: 110,
        onTap: () {
          Get.toNamed(Routes.CATALOG_PRODUCT, arguments: sale.storeId);
        },
      );
    }
  }

  buttonReportSalesClicked() {
    checkUserRole(role.value);
    if (isOwner) {
      Get.toNamed(Routes.REPORT_SALES, arguments: RxString(sale.storeId));
    } else {
      Get.snackbar('Invalid', "User didn't have permission");
    }
  }
}
