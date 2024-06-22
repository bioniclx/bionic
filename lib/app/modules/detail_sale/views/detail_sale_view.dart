import 'package:bionic/app/components/custom_button_icon.dart';
import 'package:bionic/app/components/custom_grid_item.dart';
import 'package:bionic/app/components/custom_text.dart';
import 'package:bionic/app/routes/app_pages.dart';
import 'package:bionic/app/utils/utility.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/detail_sale_controller.dart';

class DetailSaleView extends GetView<DetailSaleController> {
  const DetailSaleView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: primary,
            leading: Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_sharp,
                    color: primary,
                  ),
                ),
              ),
            ),
            title: Row(
              children: [
                Image.asset('assets/images/logo.png'),
              ],
            ),
          ),
        ],
        scrollDirection: Axis.vertical,
        body: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(0),
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: spaceExtraLarge,
                  decoration: const BoxDecoration(color: primary),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: paddingLarge),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomButtonWithIcon(
                        buttonText: 'Penjualan',
                        buttonIcon: Icons.arrow_right_alt_outlined,
                        buttonHeight: 110,
                        buttonWidth: 110,
                      ),
                      CustomButtonWithIcon(
                        buttonText: 'Tambah Produk',
                        buttonIcon: Icons.add,
                        buttonHeight: 110,
                        buttonWidth: 110,
                        onTap: () {
                          Get.toNamed(Routes.ADD_PRODUCT);
                        },
                      ),
                      const CustomButtonWithIcon(
                        buttonText: 'Laporan \nPenjualan',
                        buttonIcon: Icons.bar_chart_rounded,
                        buttonTextPaddingVertical: 10.0,
                        buttonHeight: 110,
                        buttonWidth: 110,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: paddingLarge,
                vertical: paddingMedium,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    text: 'Detail Penjualan',
                    textSize: textMedium,
                    textColor: Colors.black,
                    textWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: spaceMedium),
                  CustomText(
                    text: 'Nama Pembeli : ${controller.sale.name}',
                    textSize: textMedium,
                    textColor: Colors.black,
                    textWeight: FontWeight.w400,
                  ),
                  const SizedBox(height: spaceVerySmall),
                  CustomText(
                    text:
                        'Tanggal Pembelian : ${DateFormat.yMMMMEEEEd('id').format(controller.sale.createdAt)}',
                    textSize: textMedium,
                    textColor: Colors.black,
                    textWeight: FontWeight.w400,
                  ),
                  const SizedBox(height: spaceMedium),
                  const CustomText(
                    text: 'Produk yang Dibeli',
                    textSize: textMedium,
                    textColor: Colors.black,
                    textWeight: FontWeight.w600,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: GridView.builder(
                      itemCount: controller.sale.products.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        final product = controller.sale.products[index];
                        return CustomGridItem(
                          name: product.name,
                          total: (product.price * product.qty).toString(),
                          stock: product.qty.toString(),
                          image: product.image,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: spaceMedium),
                  Text("Total Pembelian : Rp ${controller.sale.total}",
                      style: const TextStyle(
                          fontSize: textMedium, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
