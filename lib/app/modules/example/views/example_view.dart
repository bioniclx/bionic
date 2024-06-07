import 'package:bionic/app/components/custom_button.dart';
import 'package:bionic/app/components/custom_cart_item.dart';
import 'package:bionic/app/components/custom_catalog_item.dart';
import 'package:bionic/app/components/custom_list.dart';
import 'package:bionic/app/components/custom_report_card.dart';
import 'package:bionic/app/components/custom_text.dart';
import 'package:bionic/app/components/sidebar.dart';
import 'package:bionic/app/utils/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import '../controllers/example_controller.dart';

class ExampleView extends GetView<ExampleController> {
  const ExampleView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Add a drawer
      drawer: const NavigationSidebar(),
      appBar: AppBar(
        //Triger scaffold context to open Drawer
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.list),
          ),
        ),
        title: const Text('Example'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            /*
            
            Custom Text

            */
            const CustomText(
              text: 'List Item',
              textSize: textLarge,
              textColor: Colors.black,
              textWeight: FontWeight.w500,
            ),
            /*

            Custom List Example

            */
            SizedBox(
              height: 400,
              child: Center(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return CustomListItem(
                      itemName: 'Endriardi',
                      itemDate: '20 Mei 2024',
                      itemPrice: 'Rp. 2.400.00',
                      itemColor: controller.statusColor,
                    );
                  },
                ),
              ),
            ),
            /*

            Custom Button example

            */
            CustomButton(
              buttonText: 'Logout',
              buttonWidth: 100,
              onTap: () {
                controller.logoutAccount();
              },
            ),
            const Divider(),
            const CustomText(
              text: 'Cart Item',
              textSize: textLarge,
              textColor: Colors.black,
              textWeight: FontWeight.w500,
            ),
            Column(
              children: [
                /*
                
                Cart Item Example
                
                */
                SizedBox(
                  height: 500,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.itemName.length,
                    itemBuilder: (context, index) {
                      return CustomCartItem(
                        itemName: controller.itemName[index],
                        itemPrice: 'Rp 15.000',
                        itemCount: controller.itemCount,
                        itemColor: controller.statusColor,
                        onAdd: () => controller.increment(),
                        onMinus: () => controller.decrement(),
                      );
                    },
                  ),
                ),
              ],
            ),
            CustomButton(
              buttonText: 'Add',
              buttonWidth: 100,
              onTap: () {
                Get.snackbar('Value', '${controller.itemCount}');
              },
            ),
            const Divider(),
            const CustomText(
              text: 'Report Card',
              textSize: textLarge,
              textColor: Colors.black,
              textWeight: FontWeight.w400,
            ),
            /*
            when use it in row make sure use a expanded
            this because default width are infinity
            */
            Row(
              children: [
                Expanded(
                  child: CustomReportCard(
                    reportTitle: 'Total Penjualan',
                    reportDetail: 32,
                    reportBorderColor: setReportBorderColor(1),
                  ),
                ),
                Expanded(
                  child: CustomReportCard(
                    reportTitle: 'Total Penjualan',
                    reportDetail: 32,
                    reportBorderColor: setReportBorderColor(2),
                  ),
                ),
              ],
            ),
            /*
            Outside outside row
            */
            CustomReportCard(
              reportTitle: 'Total Penjualan',
              reportDetail: 32,
              reportBorderColor: setReportBorderColor(0),
            ),
            //or you can set width if you needed
            CustomReportCard(
              reportTitle: 'Total Penjualan',
              reportDetail: 32,
              reportBorderColor: setReportBorderColor(4),
              //add this nullable variable
              reportCardWidth: 200,
            ),
            const SizedBox(height: spaceMedium),

            const Divider(),

            const CustomText(
              text: 'Catalog Item',
              textSize: textLarge,
              textColor: Colors.black,
              textWeight: FontWeight.w400,
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: spaceSmall),
              child: Column(
                children: [
                  CustomCatalogItem(
                    productName: '',
                    productPrice: 1000,
                    productCategory: '',
                    productStock: 2,
                  ),
                  SizedBox(height: spaceSmall),
                  CustomCatalogItem(
                    productName: 'Mawar',
                    productPrice: 2000,
                    productCategory: 'Rose',
                    productStock: 2,
                  ),
                  SizedBox(height: spaceMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
