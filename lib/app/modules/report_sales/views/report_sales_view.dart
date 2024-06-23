import 'dart:math';

import 'package:bionic/app/components/custom_list.dart';
import 'package:bionic/app/components/custom_report_card.dart';
import 'package:bionic/app/components/custom_report_catgory.dart';
import 'package:bionic/app/components/custom_text.dart';
import 'package:bionic/app/models/sale.dart';
import 'package:bionic/app/routes/app_pages.dart';
import 'package:bionic/app/utils/utility.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
        title: const CustomText(
          text: "Laporan Penjualan",
          textSize: textTitle,
          textColor: Colors.black,
          textWeight: FontWeight.w600,
        ),
        centerTitle: false,
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
                    int test = controller.calculateTotalRevenue(sales);
                    int item = controller.calculateTotalItems(sales);
                    return GridView.count(
                      shrinkWrap: true,
                      primary: false,
                      crossAxisCount: 2,
                      childAspectRatio: (3 / 2),
                      children: [
                        CustomReportCard(
                          reportTitle: 'Total Penjualan',
                          reportDetail: test,
                          reportBorderColor: Colors.green,
                        ),
                        CustomReportCard(
                          reportTitle: 'Total item',
                          reportDetail: item,
                          reportBorderColor: Colors.blue,
                        ),
                      ],
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
          const SizedBox(height: spaceSmall),
          const Divider(),
          const SizedBox(height: spaceMedium),
          const Padding(
            padding: EdgeInsets.only(left: paddingMedium, bottom: paddingSmall),
            child: CustomText(
              text: 'Detail Laporan',
              textSize: textTitle,
              textColor: Colors.black,
              textWeight: FontWeight.w600,
            ),
          ),
          Obx(
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
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.DETAIL_SALE, arguments: sale);
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
