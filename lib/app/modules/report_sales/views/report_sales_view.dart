import 'package:bionic/app/components/custom_report_card.dart';
import 'package:bionic/app/components/custom_report_catgory.dart';
import 'package:bionic/app/utils/utility.dart';
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
                  CustomReportCategory(
                    text: "Test",
                    backgroundColor: primary,
                    borderColor: primary,
                    textColor: Colors.white,
                    onTap: () {
                      Get.snackbar('title', 'Test 1');
                    },
                  ),
                  const SizedBox(width: paddingSmall),
                  CustomReportCategory(
                    text: "Test 2",
                    backgroundColor: Colors.white,
                    borderColor: primary,
                    textColor: primary,
                    onTap: () {
                      Get.snackbar('title', "Test 2");
                    },
                  ),
                  const SizedBox(width: paddingSmall),
                  CustomReportCategory(
                    text: "Test 3",
                    backgroundColor: Colors.white,
                    borderColor: primary,
                    textColor: primary,
                    onTap: () {
                      Get.snackbar('title', "Test 3");
                    },
                  ),
                  const SizedBox(width: paddingSmall),
                  CustomReportCategory(
                    text: "Test 4",
                    backgroundColor: Colors.white,
                    borderColor: primary,
                    textColor: primary,
                    onTap: () {
                      Get.snackbar('title', "Test 4");
                    },
                  ),
                  const SizedBox(width: paddingSmall),
                  CustomReportCategory(
                    text: "Test 4",
                    backgroundColor: Colors.white,
                    borderColor: primary,
                    textColor: primary,
                    onTap: () {
                      Get.snackbar('title', "Test 4");
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
        ],
      ),
    );
  }
}
