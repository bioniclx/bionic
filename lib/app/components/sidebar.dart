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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class NavigationSidebar extends StatelessWidget {
  final Color? isActived1;
  final Color? isActived2;
  final String storeName;
  final String role;
  const NavigationSidebar({
    super.key,
    this.isActived1,
    this.isActived2,
    required this.storeName,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Flexible(
            child: ListView(
              children: [
                SizedBox(
                  height: 150,
                  child: GestureDetector(
                    child: DrawerHeader(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: storeName,
                                textSize: textMedium,
                                textColor: Colors.black,
                                textWeight: FontWeight.w600,
                              ),
                              const SizedBox(height: paddingVerySmall),
                              CustomText(
                                text: role,
                                textSize: textSmall,
                                textColor: primary,
                                textWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          const CircleAvatar(
                            radius: 32,
                            backgroundColor: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Get.toNamed(Routes.PROFILE);
                    },
                  ),
                ),
                GestureDetector(
                  child: const SizedBox(
                    height: tileNormal,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: paddingMedium),
                        child: CustomText(
                          text: 'Example',
                          textSize: textMedium,
                          textColor: primary,
                          textWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {},
                ),
                const Divider(),
                GestureDetector(
                  child: const SizedBox(
                    height: tileNormal,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: paddingMedium),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              text: 'Katalog',
                              textSize: textMedium,
                              textColor: primary,
                              textWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.toNamed(Routes.CATALOG_PRODUCT);
                  },
                ),
                const Divider(),
                GestureDetector(
                  child: const SizedBox(
                    height: tileNormal,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: paddingMedium),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              text: 'History',
                              textSize: textMedium,
                              textColor: primary,
                              textWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {},
                ),
                const Divider(),
                GestureDetector(
                  child: const SizedBox(
                    height: tileNormal,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: paddingMedium),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              text: 'Laporan',
                              textSize: textMedium,
                              textColor: primary,
                              textWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {},
                ),
                const Divider(),
                GestureDetector(
                  child: const SizedBox(
                    height: tileNormal,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: paddingMedium),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              text: 'Penjualan',
                              textSize: textMedium,
                              textColor: primary,
                              textWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {},
                ),
                const Divider(),
                GestureDetector(
                  child: const SizedBox(
                    height: tileNormal,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: paddingMedium),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              text: 'Tambah Produk',
                              textSize: textMedium,
                              textColor: primary,
                              textWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
          ListView(
            shrinkWrap: true,
            children: [
              const Divider(color: primary, height: 2.0),
              GestureDetector(
                child: const SizedBox(
                  height: tileNormal,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: paddingMedium),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomText(
                            text: 'Tambah Karyawan',
                            textSize: textMedium,
                            textColor: primary,
                            textWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(
                          Icons.person_add,
                          color: primary,
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {},
              ),
              const Divider(),
              GestureDetector(
                child: const SizedBox(
                  height: tileNormal,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: paddingMedium),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomText(
                            text: 'Keluar',
                            textSize: textMedium,
                            textColor: primary,
                            textWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(
                          Icons.login_outlined,
                          color: primary,
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
              ),
              const Divider(color: primary, height: 2.0),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: paddingMedium),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(),
                        CustomText(
                          text: 'Bionic, Inc.',
                          textSize: textSmall,
                          textColor: Colors.grey,
                          textWeight: FontWeight.w400,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(),
                        CustomText(
                          text: 'Rohand, Co.',
                          textSize: textSmall,
                          textColor: Colors.grey,
                          textWeight: FontWeight.w400,
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
