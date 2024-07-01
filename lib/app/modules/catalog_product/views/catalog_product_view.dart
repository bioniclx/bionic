import 'dart:io';

import 'package:bionic/app/components/custom_snackbar.dart';
import 'package:bionic/app/components/custom_update_product_dialog.dart';
import 'package:bionic/app/components/custom_catalog_item.dart';
import 'package:bionic/app/models/product.dart';
import 'package:bionic/app/routes/app_pages.dart';
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
                          border: Border.all(color: Colors.grey),
                        ),
                        child: const Icon(Icons.arrow_back_rounded),
                      ),
                    ),
                    onTap: () {
                      Get.back();
                    },
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.searchController,
                          decoration: const InputDecoration(
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
          body: Obx(() {
            if (controller.productList.isEmpty) {
              return Center(child: Text('No products found'));
            }
            return ListView.builder(
                itemCount: controller.productList.length,
                itemBuilder: (context, index) {
                  final product = controller.productList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: paddingSmall,
                      horizontal: paddingMedium,
                    ),
                    child: GestureDetector(
                      child: CustomCatalogItem(
                        productName: "${product.productName}",
                        productPrice: int.parse("${product.productPrice}"),
                        productStock: int.parse("${product.productStock}"),
                        productCategory: "${product.productCategory}",
                        productImage: "${product.productImage}",
                        isDelete: checkUserRole(
                            controller.homeController.roleUser.value),
                        onTap: () {
                          controller.deleteProduct("${product.id}");
                        },
                      ),
                      onTap: () {
                        if (checkUserRole(
                            controller.homeController.roleUser.value)) {
                          controller.updateProductNameController.text =
                              "${product.productName}";
                          controller.updateProductPrice.text =
                              "${product.productPrice}";
                          controller.updateProductStock.text =
                              "${product.productStock}";
                          controller.updateProductCategory.text =
                              "${product.productCategory}";
                          Get.dialog(
                            CustomUpdateProductDialog(
                              productImage: "${product.productImage}",
                              image: controller.image,
                              productName:
                                  controller.updateProductNameController,
                              productCategory: controller.updateProductCategory,
                              productPrice: controller.updateProductPrice,
                              productStock: controller.updateProductStock,
                              onTap: () {
                                controller.updateProduct(
                                  product.id.toString(),
                                  controller.updateProductNameController.text,
                                  controller.updateProductCategory.text,
                                  int.parse(controller.updateProductStock.text),
                                  int.parse(controller.updateProductPrice.text),
                                  File(controller.image.value.path),
                                );
                              },
                              getImage: () async {
                                await controller.getImage(true);
                              },
                            ),
                          );
                        } else {
                          showErrorSnackbar('Error',
                              'Kamu tidak memiliki akses untuk mengedit produk');
                        }
                      },
                    ),
                  );
                });
          })),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        onPressed: () {
          if (checkUserRole(controller.homeController.roleUser.value)) {
            Get.toNamed(Routes.ADD_PRODUCT);
          } else {
            showErrorSnackbar(
                'Error', 'Kamu tidak memiliki akses untuk menambahkan produk');
          }
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
