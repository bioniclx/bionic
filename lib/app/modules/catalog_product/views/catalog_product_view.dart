import 'dart:io';

import 'package:bionic/app/components/custom_update_product_dialog.dart';
import 'package:bionic/app/components/custom_catalog_item.dart';
import 'package:bionic/app/models/product.dart';
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
        body: StreamBuilder<List<Product>>(
          stream: controller.getProductItem(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error"),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: paddingSmall,
                      horizontal: paddingMedium,
                    ),
                    child: GestureDetector(
                      child: CustomCatalogItem(
                        productName: "${snapshot.data?[index].productName}",
                        productPrice:
                            int.parse("${snapshot.data?[index].productPrice}"),
                        productStock:
                            int.parse("${snapshot.data?[index].productStock}"),
                        productCategory:
                            "${snapshot.data?[index].productCategory}",
                        productImage: "${snapshot.data?[index].productImage}",
                        isDelete: checkUserRole(
                            controller.homeController.roleUser.value),
                        onTap: () {
                          controller
                              .deleteProduct("${snapshot.data?[index].id}");
                        },
                      ),
                      onTap: () {
                        if (checkUserRole(
                            controller.homeController.roleUser.value)) {
                          controller.updateProductNameController.text =
                              "${snapshot.data?[index].productName}";
                          controller.updateProductPrice.text =
                              "${snapshot.data?[index].productPrice}";
                          controller.updateProductStock.text =
                              "${snapshot.data?[index].productStock}";
                          controller.updateProductCategory.text =
                              "${snapshot.data?[index].productCategory}";
                          Get.dialog(
                            CustomUpdateProductDialog(
                              productImage:
                                  "${snapshot.data?[index].productImage}",
                              image: controller.image,
                              productName:
                                  controller.updateProductNameController,
                              productCategory: controller.updateProductCategory,
                              productPrice: controller.updateProductPrice,
                              productStock: controller.updateProductStock,
                              onTap: () {
                                controller.updateProduct(
                                  snapshot.data![index].id.toString(),
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
                          Get.snackbar(
                            'Error',
                            'You dont have permission to update this product',
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      },
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text('Has No Data'),
              );
            }
          },
        ),
      ),
    );
  }
}
