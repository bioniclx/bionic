// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bionic/app/components/custom_button.dart';
import 'package:bionic/app/components/custom_text_field.dart';
import 'package:bionic/app/utils/utility.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';

import '../controllers/sales_controller.dart';

class SalesView extends GetView<SalesController> {
  const SalesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Penjualan',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(26.0),
            child: Column(
              children: <Widget>[
                // get data from firebase
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownSearch<String>(
                        items: controller.productDropdown
                            .map((item) => item.name)
                            .toList(),
                        itemAsString: (item) {
                          return item;
                        },
                        onChanged: (value) {
                          controller.setSelectedItem(controller.productDropdown
                              .firstWhere((element) => element.name == value));
                        },
                        popupProps: PopupProps.menu(
                            showSearchBox: true,
                            isFilterOnline: true,
                            title: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Text(
                                'Cari Produk',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87),
                              ),
                            ),
                            itemBuilder: (context, item, isSelected) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(item),
                              );
                            },
                            fit: FlexFit.loose,
                            constraints:
                                BoxConstraints(maxHeight: Get.height * 0.5)),
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: primary,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 18, horizontal: 18),
                            hintText: "Pilih Produk",
                            hintStyle: const TextStyle(
                                color: primary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        selectedItem: null,
                      ),
                    );
                  }
                }),

                const SizedBox(height: spaceSmall),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        buttonText: 'Tambah Produk',
                        buttonWidth: 1,
                        onTap: () {
                          controller.addProduct();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: spaceMedium),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Produk Yang Dibeli',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: spaceVerySmall,
                            ),
                            Obx(() => Text(
                                'Total Produk: ${controller.cartProducts.length}'))
                          ],
                        ),
                        const Expanded(child: SizedBox()),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            controller.clearAllProduct();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: spaceSmall,
                    ),
                    LayoutBuilder(builder: (context, constraints) {
                      return Obx(() {
                        if (controller.cartProducts.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: spaceLarge, horizontal: spaceMedium),
                            child: const Center(
                              child: Text('Belum ada produk yang ditambahkan'),
                            ),
                          );
                        } else {
                          return Obx(() {
                            if (controller.cartProducts.length < 3) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.cartProducts.length,
                                itemBuilder: (context, index) {
                                  var product = controller.cartProducts[index];
                                  return ProductCard(
                                    id: product.id,
                                    qty: product.qty,
                                    name: product.productName,
                                    price: product.productPrice,
                                    image: product.productImage,
                                  );
                                },
                              );
                            }
                            return ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxHeight: 500,
                              ),
                              child: ListView.builder(
                                itemCount: controller.cartProducts.length,
                                itemBuilder: (context, index) {
                                  var product = controller.cartProducts[index];
                                  return ProductCard(
                                    id: product.id,
                                    qty: product.qty,
                                    name: product.productName,
                                    price: product.productPrice,
                                    image: product.productImage,
                                  );
                                },
                              ),
                            );
                          });
                        }
                      });
                    }),
                    const SizedBox(
                      height: spaceMedium,
                    ),
                    const Text(
                      'Detail Pembeli',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: spaceSmall,
                    ),
                    CustomTextField(
                        textTitle: "Nama Pembeli",
                        textFieldController: controller.nameTextFieldController,
                        textFieldType: TextInputType.text,
                        obsecureText: false),
                    const SizedBox(height: spaceSmall),
                    CustomTextField(
                        textTitle: "Alamat Pembeli",
                        textFieldController:
                            controller.adressTextFieldController,
                        textFieldType: TextInputType.text,
                        obsecureText: false),
                    const SizedBox(height: spaceSmall),
                    CustomTextField(
                        textTitle: "Nomor Telepon",
                        textFieldController:
                            controller.phoneTextFieldController,
                        textFieldType: TextInputType.number,
                        obsecureText: false),
                    const SizedBox(height: spaceMedium),
                    const Text(
                      'Diskon',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: spaceSmall,
                    ),
                    CustomTextField(
                        textTitle: "Diskon",
                        textFieldController:
                            controller.diskonTextFieldController,
                        textFieldType: TextInputType.number,
                        obsecureText: false),
                    const SizedBox(height: 10),
                    const Text(
                      "Isi kosong jika tidak ada diskon",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: spaceMedium),
                    const Text(
                      'Total Pembelian',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: spaceSmall,
                    ),
                    Obx(() {
                      if (controller.cartProducts.isNotEmpty) {
                        return CustomTextField(
                            textTitle: "Total Pembelian",
                            textFieldController:
                                controller.totalAmountController,
                            textFieldType: TextInputType.number,
                            enabled: false,
                            obsecureText: false);
                      } else {
                        return const Text("Belum ada produk yang ditambahkan");
                      }
                    }),
                    const SizedBox(
                      height: spaceMedium,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            buttonText: 'Simpan Penjualan',
                            buttonWidth: 1,
                            onTap: () {
                              controller.storeSale();
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: spaceMedium,
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

class ProductCard extends StatelessWidget {
  final String id;
  final String name;
  final int price;
  final String image;
  final int qty;

  const ProductCard({
    Key? key,
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.qty,
  }) : super(key: key);

  String formatCurrency(int amount) {
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final SalesController controller = Get.find();
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      shadowColor: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(image, fit: BoxFit.cover),
                )),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Obx(() {
                    int qty = controller.getProductQuantity(id);
                    return Text(formatCurrency(price * qty));
                  }),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          controller.updateProductQuantity(id, qty - 1);
                        },
                      ),
                      Obx(() {
                        return Text("${controller.getProductQuantity(id)}");
                      }),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          controller.updateProductQuantity(id, qty + 1);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                controller.removeProduct(id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
