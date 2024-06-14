// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bionic/app/components/custom_button.dart';
import 'package:bionic/app/components/custom_text_field.dart';
import 'package:bionic/app/utils/utility.dart';

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
                CustomDropdown(
                  items: controller.productDropdown,
                  onChanged: (value) {
                    log('changing value to: $value');
                  },
                ),
                const SizedBox(height: spaceSmall),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        buttonText: 'Tambah Produk',
                        buttonWidth: 1,
                        onTap: () {},
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
                    const Text(
                      'Produk Yang Dibeli',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: spaceSmall,
                    ),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 600,
                          ),
                          child: ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return const ProductCard(
                                name: 'Buket Bunga Mawar Merah',
                                price: 15000,
                              );
                            },
                          ),
                        );
                      },
                    ),
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
                        textFieldController: controller.productNameController,
                        textFieldType: TextInputType.text,
                        obsecureText: false),
                    const SizedBox(height: spaceSmall),
                    CustomTextField(
                        textTitle: "Alamat Pembeli",
                        textFieldController: controller.productNameController,
                        textFieldType: TextInputType.text,
                        obsecureText: false),
                    const SizedBox(height: spaceSmall),
                    CustomTextField(
                        textTitle: "Nomor Telepon",
                        textFieldController: controller.productNameController,
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
                        textFieldController: controller.productNameController,
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
                    CustomTextField(
                        textTitle: "Total Pembelian",
                        textFieldController: controller.productNameController,
                        textFieldType: TextInputType.number,
                        obsecureText: false),
                    const SizedBox(
                      height: spaceMedium,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            buttonText: 'Tambah Produk',
                            buttonWidth: 1,
                            onTap: () {},
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
  final String name;
  final int price;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
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
            ),
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
                  Text('Rp ${price.toString()},-'),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {},
                      ),
                      const Text('1'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
