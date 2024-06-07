import 'package:bionic/app/components/custom_add_product_dialog.dart';
import 'package:bionic/app/components/custom_catalog_item.dart';
import 'package:bionic/app/utils/utility.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/catalog_product_controller.dart';

class CatalogProductView extends GetView<CatalogProductController> {
  const CatalogProductView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: Colors.white,
            leading: GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: paddingSmall,
                  top: paddingVerySmall,
                  bottom: paddingVerySmall,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(242, 242, 242, 1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Icon(Icons.arrow_back_rounded),
                ),
              ),
              onTap: () {
                Get.back();
              },
            ),
            title: const Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(140, 140, 140, 1),
                        ),
                      ),
                      contentPadding: EdgeInsets.all(1),
                      border: OutlineInputBorder(),
                      hintText: 'search',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: paddingSmall,
                horizontal: paddingMedium,
              ),
              child: GestureDetector(
                child: const CustomCatalogItem(),
                onTap: () {
                  Get.dialog(
                    CustomAddProductDialog(
                      productName: controller.updateProductNameController,
                      productCategory: controller.updateProductCategory,
                      productPrice: controller.updateProductPrice,
                      productStock: controller.updateProductStock,
                      onTap: () {
                        Get.back();
                        Get.snackbar(
                          controller.updateProductNameController.text,
                          'message',
                        );
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
