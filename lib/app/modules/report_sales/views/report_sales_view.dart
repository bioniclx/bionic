import 'dart:math';

import 'package:bionic/app/components/custom_list.dart';
import 'package:bionic/app/components/custom_report_card.dart';
import 'package:bionic/app/components/custom_report_catgory.dart';
import 'package:bionic/app/models/sale.dart';
import 'package:bionic/app/utils/utility.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/report_sales_controller.dart';

class ReportSalesView extends GetView<ReportSalesController> {
  const ReportSalesView({super.key});
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
                border: Border.all(color: Colors.grey),
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
      body: ListView(
        shrinkWrap: true,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(paddingMedium),
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  //generate list
                  ...List.generate(
                    //length list by srotedBy length
                    controller.sortedBy.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: paddingSmall),
                        child: Obx(
                          () => CustomReportCategory(
                            text: controller.sortedBy[index],
                            //change background color by index value
                            backgroundColor: controller.isActivated(
                              index,
                              false,
                            ),
                            borderColor: primary,
                            //change text color by index value
                            textColor: controller.isActivated(
                              index,
                              true,
                            ),
                            onTap: () {
                              //change selctedCategory value to clicked index
                              controller.selectedCategory.value = index;
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(spaceVerySmall),
            width: double.infinity,
            child: GridView.count(
              shrinkWrap: true,
              primary: false,
              crossAxisCount: 2,
              childAspectRatio: (3 / 2),
              children: const [
                CustomReportCard(
                  reportTitle: 'Total Penjualan',
                  reportDetail: 13,
                  reportBorderColor: Colors.green,
                ),
                CustomReportCard(
                  reportTitle: 'Total Penjualan',
                  reportDetail: 13,
                  reportBorderColor: Colors.blue,
                ),
                CustomReportCard(
                  reportTitle: 'Total Penjualan',
                  reportDetail: 13,
                  reportBorderColor: primary,
                ),
                CustomReportCard(
                  reportTitle: 'Total Penjualan',
                  reportDetail: 13,
                  reportBorderColor: Colors.purple,
                ),
              ],
            ),
          ),
          Center(
            child: Obx(
              () => StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: controller.getSales(controller.selectedCategory.value),
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
                          child: CustomListItem(
                            itemName: sale.name,
                            itemDate: sale.name,
                            itemPrice: "Rp. ${sale.total}",
                            itemColor: statusColorList[Random.secure()
                                .nextInt(statusColorList.length)],
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
          ),
        ],
      ),
    );
  }
}
