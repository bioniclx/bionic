/*

Widget drawer for sidebar
How to use : 
  - call this widget on your context drawer
  - open drawer by calling a scaffold context and open drawer
    Scaffold.of(context).openDrawer();
*/

import 'package:bionic/app/components/custom_text.dart';
import 'package:bionic/app/routes/app_pages.dart';
import 'package:bionic/app/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationSidebar extends StatelessWidget {
  final Color? isActived1;
  final Color? isActived2;
  const NavigationSidebar({
    super.key,
    this.isActived1,
    this.isActived2,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Center(
              child: CustomText(
                text: 'P R O F I L E',
                textSize: textMedium,
                textColor: Colors.grey,
                textWeight: FontWeight.w800,
              ),
            ),
          ),
          ListTile(
            title: const CustomText(
              text: 'Example',
              textSize: textMedium,
              textColor: primary,
              textWeight: FontWeight.w500,
            ),
            onTap: () {
              Get.toNamed(Routes.EXAMPLE);
            },
          ),
          const Divider(),
          ListTile(
            title: const CustomText(
              text: 'Profile',
              textSize: textMedium,
              textColor: primary,
              textWeight: FontWeight.w500,
            ),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: const CustomText(
              text: 'Home',
              textSize: textMedium,
              textColor: primary,
              textWeight: FontWeight.w500,
            ),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: const CustomText(
              text: 'Katalog',
              textSize: textMedium,
              textColor: primary,
              textWeight: FontWeight.w500,
            ),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: const CustomText(
              text: 'History',
              textSize: textMedium,
              textColor: primary,
              textWeight: FontWeight.w500,
            ),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: const CustomText(
              text: 'Laporan',
              textSize: textMedium,
              textColor: primary,
              textWeight: FontWeight.w500,
            ),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: const CustomText(
              text: 'Penjualan',
              textSize: textMedium,
              textColor: primary,
              textWeight: FontWeight.w500,
            ),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: const CustomText(
              text: 'Tambah Produk',
              textSize: textMedium,
              textColor: primary,
              textWeight: FontWeight.w500,
            ),
            onTap: () {},
          ),
          const Divider(),
        ],
      ),
    );
  }
}
