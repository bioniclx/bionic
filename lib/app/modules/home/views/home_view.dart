import 'dart:math';

import 'package:bionic/app/components/custom_button_icon.dart';
import 'package:bionic/app/components/custom_list.dart';
import 'package:bionic/app/components/custom_text.dart';
import 'package:bionic/app/components/sidebar.dart';
import 'package:bionic/app/models/sale.dart';
import 'package:bionic/app/routes/app_pages.dart';
import 'package:bionic/app/utils/utility.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: FutureBuilder(
        future: controller.getStoreProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            Map<String, dynamic>? store = snapshot.data!.data();
            return NavigationSidebar(
              storeName: "${store!['store_name']}",
              role: getRoleAccount(store['role']),
            );
          } else {
            return const Text('Has no data');
          }
        },
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: primary,
            leading: Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Image.asset('assets/images/side-bar-icon.png'),
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
                      CustomButtonWithIcon(
                        buttonText: 'Penjualan',
                        buttonIcon: Icons.arrow_right_alt_outlined,
                        buttonHeight: 110,
                        buttonWidth: 110,
                        onTap: () {
                          // Get.snackbar("title", controller.storeId.value);
                          Get.toNamed(Routes.SALES,
                              arguments: controller.storeId.value);
                        },
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
                      CustomButtonWithIcon(
                        buttonText: 'Laporan \nPenjualan',
                        buttonIcon: Icons.bar_chart_rounded,
                        buttonTextPaddingVertical: 10.0,
                        buttonHeight: 110,
                        buttonWidth: 110,
                        onTap: () {
                          Get.toNamed(Routes.REPORT_SALES);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: paddingLarge,
                vertical: paddingMedium,
              ),
              child: CustomText(
                text: 'History Penjualan',
                textSize: textMedium,
                textColor: Colors.black,
                textWeight: FontWeight.w500,
              ),
            ),
            Center(child: Obx(() {
              return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: controller.getSales(),
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
                      List<Sale> sales = controller.sales(snapshot.data!);
                      // add sales store_id from list sales
                      sales = sales
                          .where((element) =>
                              element.storeId == controller.storeId.value)
                          .toList();
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: sales.length,
                        itemBuilder: (context, index) {
                          Sale sale = sales[index];

                          return Padding(
                            padding: const EdgeInsets.all(paddingSmall),
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.DETAIL_SALE,
                                    arguments: sale);
                              },
                              child: CustomListItem(
                                itemName: sale.name,
                                itemDate: DateFormat.yMMMMEEEEd('id')
                                    .format(sale.createdAt),
                                itemPrice: "Rp. ${sale.total}",
                                itemColor: statusColorList[Random.secure()
                                    .nextInt(statusColorList.length)],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text('Has No Data'),
                      );
                    }
                  });
            })),
          ],
        ),
      ),
    );
  }
}
