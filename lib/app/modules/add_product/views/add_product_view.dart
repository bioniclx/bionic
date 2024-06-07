import 'package:bionic/app/components/custom_button.dart';
import 'package:bionic/app/components/custom_text_field.dart';
import 'package:bionic/app/utils/utility.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  const AddProductView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: const Text('Tambah Produk'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          right: paddingMedium,
          left: paddingMedium,
        ),
        child: ListView(
          children: [
            const SizedBox(height: spaceLarge),
            CustomTextField(
              textTitle: 'Nama Barang',
              textFieldController: controller.productNameController,
              textFieldType: TextInputType.name,
              obsecureText: false,
            ),
            const SizedBox(height: spaceMedium),
            CustomTextField(
              textTitle: 'Harga',
              textFieldController: controller.productPriceController,
              textFieldType: TextInputType.number,
              obsecureText: false,
            ),
            const SizedBox(height: spaceMedium),
            CustomTextField(
              textTitle: 'Kategori',
              textFieldController: controller.productCategoryController,
              textFieldType: TextInputType.name,
              obsecureText: false,
            ),
            const SizedBox(height: spaceMedium),
            CustomTextField(
              textTitle: 'Jumlah Stok',
              textFieldController: controller.productCountController,
              textFieldType: TextInputType.number,
              obsecureText: false,
            ),
            const SizedBox(height: spaceLarge),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    buttonText: 'Test',
                    buttonWidth: 1,
                    onTap: () {
                      controller.addProduct(
                        controller.productNameController.text,
                        int.parse(controller.productPriceController.text),
                        int.parse(controller.productCountController.text),
                        controller.productCategoryController.text,
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: spaceLarge),
          ],
        ),
      ),
    );
  }
}
